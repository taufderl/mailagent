class ListMailer < ActionMailer::Base
  default from: "mailagent@taufderl.de"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.list_mailer.send_to_list.subject
  
  # just a test method 
  def send_to_list(lists)    
    mail subject: 'TestMail mit Betreff', to: get_recipients_from_lists(lists)
  end
  
  def send_email(email)
    if ENV['MAILAGENT_DEBUG_MODE']
        @content = "The following mail has been send via Mailagent: \n" +
                 "Subject: #{email.subject} \n" +
                 "To: #{get_recipients_from_lists(email.lists)} \n" +
                 "Content: \n #{email.content}"
        mail subject: "[Mailagent-debugger]", to: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']
        
    else
      @content = email.content  
      mail subject: email.subject, to: get_recipients_from_lists(email.lists)
    end
  end
  
  private
  
  def get_recipients_from_lists(lists)
    recipients = Set.new
    lists.each do |list|
      list.users.each do |user|
        recipients << user.email        
      end
    end
    recipients.to_a
  end
  
end
