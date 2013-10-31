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
	3. get config/application.yml from taufderl and adapt database settings
 		 - database settings (mysql)
		- mailer settings (mailserver and login)
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

# TODO:

## important functionality

- finish import functionality
- remove old lists mailer
- dashboard

## To make it nicer
- tooltips
- nice alerts and notices based on localization file

## Verify
- all translations are there



