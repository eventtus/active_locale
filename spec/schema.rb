ActiveRecord::Schema.define(version: 0) do
  enable_extension 'hstore'
  create_table :pages, force: true do |t|
    t.hstore :name_translations
    t.string :name
  end
end
