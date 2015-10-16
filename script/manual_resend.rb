
filename = "./maildump_broken-mail.log"

result = `curl -X POST -d @"#{filename}" http://localhost:3000/incoming_messages`

puts result
