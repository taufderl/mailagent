class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      received_mail = Mail.new(params[:message])
      
      ListMailer.send_debug_email(params[:message]).deliver
      
      # create email object, find user and set subject
      email = Email.new
      email.user = User.find_by_email(received_mail.from)
      
      #test if user exists in DB
      if email.user == nil
        ErrorMailer.send_no_such_user_error(received_mail, email).deliver
        return false
      end
      email.subject = received_mail.subject
      
      #ListMailer.send_debug_email(email.errors.inspect).deliver

      # parse all parts of mail
      if email.html_part
        email.html_part = received_mail.html_part.body.decoded
      end
      if email.text_part
        email.text_part = received_mail.text_part.body.decoded
      end
      if (email.html_part == nil && email.text_part == nil) #happens for GMX apparently
        email.text_part = received_mail.body.decoded
      end
      
      #get attachments
      if received_mail.has_attachments?
        #TODO: pass attachments to next mail
      end
      
      #parse lists from incoming mail
      email.lists = parse_lists_from_subject(received_mail)
      
      
      #User has to be found and in the targetting lists, if not send back error message not
      if (email.list_ids - email.user.list_ids).any?
        ErrorMailer.send_user_not_in_list_error(received_mail, email).deliver
        return false
      end
      
      #then the mail is valid
      if email.save
        #Send mail and be happy
        ListMailer.send_email(email).deliver
          #TODO: if not delivered
      else
        #Strange thing happened, notify owner
        ListMailer.send_debug_email("NOT Successful!\n" + email.inspect).deliver
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
