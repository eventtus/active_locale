module ActiveLocale
  module Localizable # :nodoc:
    extend ActiveSupport::Concern

    class_methods do
      # rubocop:disable Metrics/MethodLength
      def translates(*attrs)
        raise(ArgumentError, 'must have at least one record to localize') if attrs.empty?

        self.translated_attrs = attrs
        attrs.each do |attr_name|
          define_method "#{attr_name}=" do |value|
            self[attr_name] = value if I18n.default_locale == I18n.locale
            write_translation(attr_name, value)
          end

          define_method attr_name do
            read_translation(attr_name)
          end

          define_method "#{attr_name}_translations" do
            self["#{attr_name}_translations"].try(:with_indifferent_access)
          end
        end
      end
      # rubocop:enable Metrics/MethodLength
    end

    # rubocop:disable Metrics/BlockLength
    included do
      class_attribute :translated_attrs
      # rubocop:disable Metrics/MethodLength
      def translated_fields
        fields = {}
        translated_attrs.each do |attr_name|
          next if self["#{attr_name}_translations"].nil?
          self["#{attr_name}_translations"].map do |_lang, value|
            fields[:"#{attr_name}"] = if fields[:"#{attr_name}"].present?
                                        fields[:"#{attr_name}"] + ' ' + value
                                      else
                                        value
                                      end
          end
        end
        fields
      end
      # rubocop:enable Metrics/MethodLength

      def as_json(*)
        attributes.delete_if { |k, _v| translated_attrs.map { |f| translated_attr_name(f) }.include?(k) }
      end

      def write_translation(attr_name, value, locale = I18n.locale)
        translation_store = translated_attr_name(attr_name)
        translations = send(translation_store) || {}
        send("#{translation_store}_will_change!") unless translations[locale.to_s] == value
        translations[locale.to_s] = value
        send("#{translation_store}=", translations)
        value
      end

      def read_translation(attr_name, locale = I18n.locale)
        translations = send(translated_attr_name(attr_name)) || {}
        return translations[locale] if translations.key?(locale)
        return translations[I18n.default_locale] if translations.key?(I18n.default_locale)
        self[attr_name]
      end

      def update_with_locale!(locale, *attrs)
        I18n.with_locale locale do
          update!(*attrs)
        end
      end

      def translated_attr_name(attr_name)
        "#{attr_name}_translations"
      end
    end
  end
end
