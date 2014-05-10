# README

* Ruby version

* System dependencies

* Configuration --> config/application.yml

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

1. pull github repository
2. run bundle install
3. create config/application.yml ad add the following settings:
	
	# SMTP SERVER SETTINGS
	EMAIL_USERNAME:
	EMAIL_PASSWORD:
	EMAIL_SERVER_ADRESS:
	
	# Database settings
	UBERSPACE_MYSQL_USER:
	UBERSPACE_MYSQL_PASSWORD:
	UBERSPACE_MYSQL_DATABASE:
	
	#MAILAGENT_DEBUG_MODE: # if wanted
	MAILAGENT_DEBUG_MAIL_ADDRESS:
	MAILAGENT_ADMIN_MAIL_ADDRESS:
	
	MAILAGENT_ADDRESS:
	DEFAULT_FROM_MAIL_ADDRESS:
	MAILAGENT_BASE_URL:
	
	SECRET_TOKEN:

4. create database that has been set up
5. adapt mailagent/script/mail_receiver.rb to target domain
6. mailserver incoming mail forward to mailagent/script/mail_receiver.rb
7. copy mailagent/script/mailagent into fcgi path and adapt it
8. run rake db:migrate RAILS_ENV='production'
9. run rake assets:precompile and copy asset folder if necessary to public html folder
10. run application

Changelog

- mail: reply field verteiler address
- recipients as bcc
- attachements work well
- ensure that incomingmessage is only available from same host
- if empty send no lists error
- user import
- list#show: remove user,
- add no of users to lists overview
- Gemfile add versions and divide by environments!!
- list recognition only from [] and case insensitive separated by , | \s
- remove old lists mailer
- redirect to dashboard
- xls export für liste improve: filename
- removed mail content completely
- favicon
- bug melden funktion
- exclude message param from log
- set mail status pending and then OK when received a second time!!
- dashboard
- migrate to bootstrap 3.0
- new menu bar
- confirmation for subscription delete added
- show active page in menu as active
- clean subscriptions pages
- bug when creating new user with list solved
- downcase all email inputs
- removed all unused routes for ressources
- add no of recipients to email
- clean, explain and improve import functionality
- VERIFIED: test capital letters in emails
- VERIFIED: render message for curl and save this to curl log
- users in alphabetical order
- lists and subscriptions in alphabetical order
- bug with sorting and included models fixed
- reply_to field removed
- strip emails before save
- CSV import corrected

# VERIFY THAT IT WORKS

- all translations are there

# TODO:

- warn when admin created that email and password is send out
- implement authentication with gem device to implement auto end session and stuff
- add more roles for selective lists

## To make it nicer
- tooltips
- dashboard highcharts

License
-------

Mailagent is licensed under the MIT license. See [LICENSE](LICENSE) for details.




