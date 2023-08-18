source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3', '~> 1.5.3'
  gem 'listen', '~> 3.7.1'
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.18'

# cancancan for authorisation
gem 'cancancan', '~> 3.4.0'

# figaro for setting configs through application.yml and ENV variables
gem 'figaro', '~> 1.2.0'

# Use Puma as the app server
gem 'puma', '~> 6.3.1'

group :production do
  # mysql instead of sqlite3
  gem 'mysql2', '~> 0.5.4'

  # exception notification for email exceptions
  gem 'exception_notification', '~> 4.5.0'
  
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '~> 4.2.0'
end

# mail for incoming email processing
gem 'mail', '~> 2.7.1'

# ransack for easy object search and filtering
gem 'ransack', '~> 3.2.1'

# simple form makes it easier to create forms
gem 'simple_form', '~> 5.1.0'

# roo for import of csv and odt and files
gem 'roo', '~> 2.9.0'

# pagination
gem 'will_paginate', '~> 3.3.1'
gem 'will_paginate-bootstrap', '~> 1.0.2'

# haml instead of erb templates
gem 'haml', '~> 6.0.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.13.0', require: false
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false

# use webpacker
gem 'webpacker', '~> 5.4.3'

# to communicate with the websocket
gem 'net_http_unix', '~> 0.2.2'
