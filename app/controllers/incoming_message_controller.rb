class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      mail = Mail.new(params[:message])
      ListMailer.send_debug_email(mail.inspect).deliver
      
      render :nothing => true
  end
end
