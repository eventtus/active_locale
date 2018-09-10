# ActiveLocale
  `ActiveLocale` is a Model helper that support multiple translations per field
  it uses `postgres` `hstore` to save multiple data based on current `I18n`.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_locale'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_locale

## Usage
 After installing `active_locale`

 1 - create 2 coulmns for the field that require translation
   ex:
   ```
    class AddUserTranslations < ActiveRecord::Migration
      def change
        add_column :users, :name
        add_column :users, :name_translations, :hstore
      end
    end
   ```

  2 - run `bundle exec rake db:migrate`

  3 - go to the `app/models/user.rb`
   ex:
   ```
    class User < ActiveRecord::Base
       translates :name
     end
   ```

  4 - change default locale
   ex:
   ```
     I18n.with_locale :en do
       @object = Page.new(name: 'right one')
     end
   ```

   5 - while retriving it will return the value based on the current `I18n` values or the default one if it's nil
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_locale. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveLocale project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eventtus/active_locale/blob/master/CODE_OF_CONDUCT.md).
