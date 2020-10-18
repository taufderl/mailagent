source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3', '~> 1.4.2'
  gem 'listen', '~> 3.2.1'
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.5'

# cancancan for authorisation
gem 'cancancan', '~> 3.1.0'

# figaro for setting configs through application.yml and ENV variables
gem 'figaro', '~> 1.2.0'

group :production do
  # mysql instead of sqlite3
  gem 'mysql2', '~> 0.5.3'

  # exception notification for email exceptions
  gem 'exception_notification', '~> 4.4.0'

  # Use Puma as the app server
  gem 'puma', '~> 4.1'
  
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '~> 4.2.0'
end

# mail for incoming email processing
gem 'mail', '~> 2.7.1'

# ransack for easy object search and filtering
gem 'ransack', '~> 2.3.0'

# simple form makes it easier to create forms
gem 'simple_form', '~> 5.0.3'

# roo for import of csv and odt and files
gem 'roo', '~> 2.8.0'

# pagination
gem 'will_paginate', '~> 3.3.0'
gem 'will_paginate-bootstrap', '~> 1.0.2'

# haml instead of erb templates
gem 'haml', '~> 5.2.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# use webpacker
gem 'webpacker', '~> 5.2.1'

# to communicate with the websocket
gem 'net_http_unix', '~> 0.2.2'
