#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'json'
require 'net_http_unix'

startTime = Time.now

input = STDIN.read

filename = "/home/kkb/mailagent/log/maildump_#{Time.now.to_i}_input.log"
file = File.open filename, 'w'
file.write input
file.close

# create request
uri = URI('http://localhost:1337/incoming_messages')
request = Net::HTTP::Post.new uri
request.body = { "message" => input }.to_json
request['Content-Type'] = 'application/json'

# send request through socket
client = NetX::HTTPUnix.new('unix:///home/kkb/mailagent/tmp/sockets/mailagent.sock')
result = client.request(request)
puts result.body

endTime = Time.now

logFile = File.open '/home/kkb/mailagent/log/email.log', 'a'
logFile.write "#{startTime}. |#{endTime-startTime}s| #{result.body}\n"
logFile.close
