require 'cgi'



begin
# note the backticks here execute the command
`curl -X POST "message=#{CGI.escape(STDIN.read)}" http://localhost/mailagent/incoming_messages`
rescue Exception => e
  #puts e.exception
  puts "rescued from exception"
  puts e.message[0..100] 
end

curl -X POST -d @escaped_maildump http://localhost:3000/incoming_messages
