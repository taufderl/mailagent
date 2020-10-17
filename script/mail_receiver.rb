#!/usr/bin/env ruby
require 'cgi'
require 'net/http'
require 'uri'
require 'json'

startTime = Time.now

input = STDIN.read

filename = "/home/kkb/mailagent/log/maildump_#{Time.now.to_i}_input.log"
file = File.open filename, 'w'
file.write input
file.close

data = "message=#{CGI.escape(input)}"

filename_data = "/home/kkb/mailagent/log/maildump_#{Time.now.to_i}.log"
file = File.open filename_data, 'w'
file.write data
file.close

result = Net::HTTP.post URI('http://localhost:1337/incoming_messages'), { "message" => input }.to_json, "Content-Type" => "application/json"

endTime = Time.now

logFile = File.open '/home/kkb/mailagent/log/email.log', 'a'
logFile.write "#{startTime}. |#{endTime-startTime}s| #{result.body}\n"
logFile.close
