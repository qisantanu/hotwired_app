# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Prerequisites ##

1. [Ruby 3.0.3](https://www.ruby-lang.org/en/downloads/). Run `ruby --version` to check the version number.
2. [Rails 7.0.3](http://rubyonrails.org/) Install with `gem install rails` or using [RailsInstaller](http://railsinstaller.org/) (former method is recommended)
3. [(PostgreSQL) 13](https://www.postgresql.org/)

### Setup ###

1. bundle install
2. rails importmap:install
3. rails turbo:install stimulus:install
4. rails db:create; db:seed
5. Open rails console and run `Developer.insert_fake_data 20`

### for creating modal controller the command used
  rails g stimulus turbomodal
