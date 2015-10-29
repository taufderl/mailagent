source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.4'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3', '~> 1.3.11'
end
group :production do
  gem 'mysql2', '~> 0.3.12'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.4'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.7.2'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  '~> 0.12.2', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.5'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks', '~> 2.5.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.3.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.5'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# bootstrap
#gem 'less-rails', '~> 2.4.2'
#gem 'twitter-bootstrap-rails', '~> 2.2.8'
gem 'anjlab-bootstrap-rails', '~> 3.0.2.0', :require => 'bootstrap-rails'

# cancan for authorisation
gem 'cancan', '~> 1.6.10'

# figaro for setting configs through application.yml and ENV variables
gem 'figaro', '~> 1.1.1'

group :production do
  # exception notification for email exceptions
  gem 'exception_notification', '~> 4.1.1'

  # fcgi for fcgi script running
  gem 'passenger', '~> 5.0.20'
end

# mail for mail pasring ability
gem 'mail', '~> 2.6.3'

# ransack for easy object search and filtering
gem 'ransack', '~> 1.7.0'

# hirb enables nice irb output
gem 'hirb', '~> 0.7.3'

# simple form makes it easier to create forms
gem 'simple_form', '~> 3.2.0'

# roo for import of csv and odt and files
gem 'roo', '~> 2.1.1'

# pagination
gem 'will_paginate', '~> 3.0.7'
gem 'will_paginate-bootstrap', '~> 1.0.1'

gem 'haml', '~> 4.0.7'

gem "highcharts-rails"
