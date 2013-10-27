require 'cgi'

startTime = Time.now

input = "message=#{CGI.escape(STDIN.read)}"

#filename = "/home/cjgbelm/mailagent/log/maildump_#{Time.now.to_i}.log"
filename = "./maildump_#{Time.now.to_i}.log"

file = File.open filename, 'w'
file.write input
file.close

# note the backticks here execute the command
#`curl -X POST -d @"#{filename}" http://cjg-belm.de/fcgi-bin/mailagent/incoming_messages`
`curl -X POST -d @#{filename} http://localhost:3000/incoming_messages`

endTime = Time.now

#logFile = File.open '/home/cjgbelm/mailagent/log/email.log', 'a'
logFile = File.open 'email.log', 'a'
logFile.write "#{startTime}. Parsing lasted #{endTime-startTime}\n"
logFile.close
