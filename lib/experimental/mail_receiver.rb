
filename = "./maildump_1383520187.log"

# note the backticks here execute the command
#`curl -X POST -d @"#{filename}" http://cjg-belm.de/fcgi-bin/mailagent/incoming_messages`
`curl -X POST -d @#{filename} http://localhost:3000/incoming_messages`

endTime = Time.now

