class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
      ListMailer.send_debug_email(params[:message].inspect).deliver
      render :nothing => true
  end
end
