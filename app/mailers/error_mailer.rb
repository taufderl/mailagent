class ErrorMailer < ActionMailer::Base
  default from: "mailagent-noreply@taufderl.de"
  default cc: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']
  
  def send_no_such_user_error(received_mail, email)
    @received_mail = received_mail
    @email = email
    mail to: received_mail.from, subject: 'Absender-Adresse nicht registriert'
  end
  
  def send_user_not_in_list_error(received_mail, email)
    @received_mail = received_mail
    @email = email
    mail to: received_mail.from, subject: 'Absender-Adresse nicht in Verteiler'
  end
  
end
