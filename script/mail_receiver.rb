require 'cgi'
# note the backticks here execute the command
`curl -d "message=#{CGI.escape(STDIN.read)}" http://cjg-belm.de/fcgi-bin/mailagent/incoming_messages`
