require 'cgi'

startTime = Time.now




endTime = Time.now


File.write 'email.log', 'w' do |f| 
  f.write "Email received at #{startTime}. Parsing lasted #{endTime-startTime}"
end
