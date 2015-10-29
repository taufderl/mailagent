class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_authorization_check

  def create
      received_mail = Mail.new(params[:message])

      # retrieve mail_id
      message_id = received_mail.message_id

      # and check if already exists --> never handle the same mail again
      if (email = Email.find_by_mail_id message_id)
        # then set status to send successful
        email.status = 'ok'
        email.save
        render text: "|#{message_id}| received again -> OK :)"
        return false
      end

      # find user
      user = User.find_by_email(received_mail.from.map(&:downcase))
      #test if user exists in DB
      if user == nil
        ErrorMailer.send_no_such_user_error(received_mail).deliver
        render text: "|#{message_id}| No such user: #{received_mail.from.map(&:downcase)}"
        return false
      end

      # extract subject
      subject = received_mail.subject

      # and analyze subject to find lists
      lists = parse_lists_from_subject(subject)

      if lists.empty?
        # Send error reply when no list recognised
        ErrorMailer.no_lists_recognized_error(received_mail).deliver
        render text: "|#{message_id}| No lists in mail"
        return false
      end

      #If the user is a listener he has to be in all the addressed lists
      if user.listener? and (lists - user.lists).any?
        ErrorMailer.send_user_not_in_list_error(received_mail).deliver
        render text: "|#{message_id}| User not in list: #{lists-user.lists}"
        return false
      end

      # add recipients as bcc
      recipients = get_recipients_from_lists(lists)
      received_mail.bcc = recipients
      # set mailagent address as TO address
      received_mail.to = ENV['MAILAGENT_ADDRESS']

      # store to database
      email = Email.new :user => user, :subject => subject, :lists => lists, :mail_id => message_id, :recipients => recipients.length
      email.status = 'pending'

      #then the mail is valid
      if email.save
        #Send mail and be happy
        timestamp = Time.now
        File.open("./log/outgoing_mail_#{timestamp}.log", 'w') {|f| f.write(received_mail.to_s) }
        sent_mail = received_mail.deliver!

        render text: "|#{message_id}| saved and sent successfully"
      else
        #Strange thing happened, notify owner
        DebugMailer.send_email("NOT Successful!\n" + email.inspect, "ERROR while saving email, not delivered").deliver
        render text: "|#{message_id}| could not save email -> This should not happen at all."
      end

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
