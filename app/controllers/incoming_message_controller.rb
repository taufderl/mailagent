class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_authorization_check
  
  def create
      received_mail = Mail.new(params[:message])
      
      # retrieve mail_id
      message_id = received_mail.message_id
        
      # and check if already exists --> never handle the same mail again
      if Email.find_by_mail_id message_id
        # then do nothing
        render nothing: true
        return false
      end
      
      DebugMailer.send_email(params[:message], "params").deliver
      
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
      lists = parse_lists_from_subject(subject)
      
      
      if lists.empty?
        # Send error reply when no list recognised
        ErrorMailer.no_lists_recognized_error(received_mail).deliver
        render nothing: true
        return false
      end
      
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
     
      # add recipients as bcc
      received_mail.bcc = get_recipients_from_lists(lists)
      received_mail.reply_to = ENV['MAILAGENT_ADDRESS']
      
      # store to database
      email = Email.new :user => user, :subject => subject, :content => content, :lists => lists, :mail_id => message_id
      
      #then the mail is valid
      if email.save
        #Send mail and be happy
        sent_mail = received_mail.deliver!
        
        #TODO: if not delivered
      else
        #Strange thing happened, notify owner
        DebugMailer.send_email("NOT Successful!\n" + email.inspect, "ERROR while saving email, not delivered").deliver
      end
      
      render nothing: true
  end
  
  private 
 
  # returns an array of the lists that are recognized in the subject of an email
  def parse_lists_from_subject(subject)
    # extract part between '[...]'
    subject.to_s.match(/\[(.*)\]/)
    if $1
      # and create array by valid separators: \s , | 
      subject_array = $1.split(/[\s,|]/)
    else
      return []
    end
    lists = []
    List.all.each do |list|
      subject_array.each do |pot_list| 
        if pot_list.casecmp(list.name) == 0
          lists << list
        end
      end
    end
    return lists
  end
  
  # returns an array of unique users that belong to the array of lists 
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
