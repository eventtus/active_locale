RSpec.describe ActiveLocale do

  it 'should has at lease one translated attrs ' do
    expect(Page.translated_attrs).to be_a Array
    expect(Page.translated_attrs).not_to be_empty
  end

  describe 'write attribute' do
    let(:page) { Page.new(name: 'right one') }
    I18n.with_locale :es do
      it 'write the value with current local' do
        object = Page.new(name: 'right one')
        expect(object.name).to eq 'right one'
        expect(object.name_translations[I18n.locale]).to eq 'right one'
      end
    end

    it 'return to default locale if locale not found in translations hash' do
      I18n.with_locale :en do
        @object = Page.new(name: 'right one')
      end
      I18n.with_locale :es do
        expect(@object.name).to eq 'right one'
        expect(@object.name_translations[:es]).to eq nil
      end
    end
  end
end
