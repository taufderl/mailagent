class ListMailer < ActionMailer::Base
  default from: "noreply@taufderl.de"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.list_mailer.send_to_list.subject
  
  # just a test method 
  def send_to_list(lists)
    
    recipients = Set.new
    lists.each do |list|
      list.users.each do |user|
        recipients << user.email        
      end
    end
    
    mail subject: 'Betreff', to: recipients.to_a
  end
  
  def send_email(email)
    #TODO 
    
  end
end
