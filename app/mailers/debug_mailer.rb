class DebugMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_MAIL_ADDRESS']
  default to: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']
  
  def send_email(content, subject = '')
     @text_part = content
     subject = "[Mailagent-debugger] #{subject}"
     mail subject: subject
  end
  
end
