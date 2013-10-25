require 'cgi'

file = File.open(ARGV.first, 'r')

content = file.read

content = CGI.escape(content)

puts content[1..50]

file = File.open(ARGV[1], 'w')

file.write content

file.close
