class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      #TODO: document, verify and test
      received_mail = Mail.new(params[:message])
      
      email = Email.new
      email.user = User.find_by_email(received_mail.from)
      email.subject = received_mail.subject
      email.content = received_mail.text_part.body.decoded
      
      List.all.each do |list|
        email.lists << list if received_mail.to.to_s.include?(list.name)
      end
      
      #User has to be found and in the targetting lists, if not send back error message not
      if email.user && (email.list_ids - email.user.list_ids).empty?
        #then the mail is valid
        if email.save
          #Send mail and be happy
          ListMailer.send_email(email)
        else
          #TODO: Send some email back that can show the error
          ListMailer.send_debug_email("NOT Successful!\n" + email.inspect).deliver
        end
      #if the user could not be found or is not in all lists
      else
        #TODO: if the user could not be found or is not in all lists- send error message to the user     
      end
      render :nothing => true
  end
  
end
