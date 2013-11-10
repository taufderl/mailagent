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

# just done

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


# VERIFY THAT IT WORKS

- all translations are there

# TODO:


- really remove user from list?

- verify all back buttons use :back
- render message for curl and save this to curl log
- finish import functionality, and explain more detailed
- warn when admin created that email and password is send out
- implement authentication with gem device to implement auto end session and stuff
- remove unused routes for ressources

## To make it nicer
- tooltips
- dashboard highcharts




