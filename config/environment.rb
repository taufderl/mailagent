ENV['RAILS_RELATIVE_URL_ROOT'] = "/fcgi-bin/mailagent"

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Mailagent::Application.initialize!
