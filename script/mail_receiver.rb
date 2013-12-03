require 'cgi'

startTime = Time.now

input = "message=#{CGI.escape(STDIN.read)}"

filename = "/home/kjb/mailagent/log/maildump_#{Time.now.to_i}.log"
#filename = "./maildump_#{Time.now.to_i}"

file = File.open filename, 'w'
file.write input
file.close

# note the backticks here execute the command
result = `curl -X POST -d @#{filename} http://localhost:3333/incoming_messages`
#`curl -X POST -d @#{filename} http://localhost:3000/incoming_messages`

endTime = Time.now

logFile = File.open '/home/kjb/mailagent/log/email.log', 'a'
#logFile = File.open 'email.log', 'a'
logFile.write "#{startTime}. |#{endTime-startTime}s| #{result}\n"
logFile.close
