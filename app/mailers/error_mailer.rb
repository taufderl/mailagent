class ErrorMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_MAIL_ADDRESS']
  default bcc: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']
  
  def send_no_such_user_error(received_mail)
    @received_mail = received_mail
    mail to: received_mail.from, subject: t('error_mailer.no_such_user.subject')
  end
  
  def send_user_not_in_list_error(received_mail)
    @received_mail = received_mail
    mail to: received_mail.from, subject: t('error_mailer.user_not_in_list.subject')
  end
  
  def no_lists_recognized_error(received_mail)
    @received_mail = received_mail
    mail to: received_mail.from, subject: t('error_mailer.no_lists_recognized.subject')
  end
  
end
