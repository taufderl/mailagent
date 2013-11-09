class FeedbackMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_MAIL_ADDRESS']
  default to: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']
  
  def send_email(username, content, subject = '')
     @user = username
     @content = content
     @subject = subject
     mail subject: "[Mailagent-Feedback] #{subject}"
  end
end
