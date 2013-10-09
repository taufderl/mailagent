class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      
      require 'mail'
      received_mail = Mail.new(params[:message])
      
      ListMailer.send_debug_email(params[:message]).deliver
      
      email = Email.new
      email.user = User.find_by_email(received_mail.from)
      
      #get email content
      if received_email.multipart?
        #TODO: parse multipart mail
        email.content = received_mail.text_part.body.decoded
      else
        #TODO: parse single part
        email.content = received_mail.parts[0].body.decoded
      end
      
      #get attachments
      if received_mail.has_attachements?
        #TODO: pass attachments to next mail
      end
      
      
      #parse lists from incoming mail
      email.lists = parse_lists_from_subject(received_mail)
      
      email.subject = received_mail.subject
      
      #User has to be found and in the targetting lists, if not send back error message not
      if email.user && (email.list_ids - email.user.list_ids).empty?
        #then the mail is valid
        if email.save
          #Send mail and be happy
          ListMailer.send_email(email).deliver
          #TODO: if not delivered
        else
          #Strange thing happened, notify owner
          ListMailer.send_debug_email("NOT Successful!\n" + email.inspect).deliver
        end
      #if the user could not be found or is not in all lists
      else
        # if the user could not be found or is not in all lists- send error message to the user
        if email.user
          ErrorMailer.send_user_not_in_list_error(received_mail, email).deliver
        else
          ErrorMailer.send_no_such_user_error(received_mail, email).deliver
        end     
      end
      render :nothing => true
  end
  
  private 
  def parse_lists_from_addressee(received_mail)
    lists = []
    List.all.each do |list|
        lists << list if received_mail.to.to_s.include?(list.name)
    end
    lists
  end
  
  def parse_lists_from_subject(received_mail)
    lists = []
    List.all.each do |list|
        #TODO: solve with regex
        lists << list if received_mail.subject.to_s.include?(list.name)
    end
    lists
  end
  
end
