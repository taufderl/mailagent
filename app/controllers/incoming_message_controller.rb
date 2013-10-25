class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      received_mail = Mail.new(params[:message])
      
      # TODO: check for mail_id if already exists
      message_id = received_mail.message_id 
      
      #ListMailer.send_debug_email(params[:message]).deliver
      
      # find user
      user = User.find_by_email(received_mail.from)
      
      #test if user exists in DB
      if user == nil
        ErrorMailer.send_no_such_user_error(received_mail).deliver
        render nothing: true
        return false
      end
      
      # extract subject
      subject = received_mail.subject
      
      # and analyze subject to find lists 
      lists = parse_lists_from_subject(received_mail)
      
      #User has to be found and in the targeted lists, if not send back error message
      if (lists - user.lists).any?
        ErrorMailer.send_user_not_in_list_error(received_mail).deliver
        render nothing: true
        return false
      end
      
      # TODO: verify extraction of the content from the mail 
      if received_mail.text_part
        content = received_mail.text_part.body.decoded
      elsif received_mail.html_part
        content = received_mail.html_part.body.decoded
      else
        content = received_mail.body.decoded
      end
     
      # add cc TODO: change to bcc in production mode
      received_mail.to = get_recipients_from_lists(email.lists)
      
      # store to database
      email = Email.new :user => user, :subject => subject, :content => content, :lists => lists, :mail_id => message_id
      # debug mail
      ListMailer.send_debug_email(email.inspect).deliver
      #then the mail is valid
      if email.save
        #Send mail and be happy
        status = received_mail.deliver!
        
        ListMailer.send_debug_email(status).deliver
        #TODO: if not delivered
      else
        #Strange thing happened, notify owner
        ListMailer.send_debug_email("NOT Successful!\n" + email.inspect).deliver
      end
      
      render nothing: true
  end
  
  def create_safe
      received_mail = Mail.new(params[:message])
      
      #ListMailer.send_debug_email(params[:message]).deliver
      
      # create email object, find user and set subject
      email = Email.new
      email.user = User.find_by_email(received_mail.from)
      
      #test if user exists in DB
      if email.user == nil
        ErrorMailer.send_no_such_user_error(received_mail, email).deliver
        render nothing: true
        return false
      end
      email.subject = received_mail.subject
      
      #ListMailer.send_debug_email(email.errors.inspect).deliver

      # parse all parts of mail
      if received_mail.html_part
        email.html_part = received_mail.html_part.body.decoded
      end
      if received_mail.text_part
        email.text_part = received_mail.text_part.body.decoded
      end
      if (received_mail.html_part == nil && received_mail.text_part == nil) #happens for GMX apparently
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
        render nothing: true
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
      
      render nothing: true
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
        #TODO: solve with regex and only consider [] part
        lists << list if received_mail.subject.to_s.include?(list.name)
    end
    lists
  end
  
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
