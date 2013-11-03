require 'cgi'
require 'mail'

filename = "./maildump_1383520187.log_mod"

file = File.open filename, 'r'

mail = Mail.new(file.read)

puts mail.inspect

`curl -X POST "message=#{CGI.escape(STDIN.read)}" http://localhost/mailagent/incoming_messages`