module ActiveLocale
  class Engine < Rails::Engine # :nodoc:
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.send(:include, ActiveLocale::Localizable)
    end
  end
end
