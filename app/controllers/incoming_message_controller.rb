class IncomingMessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
    ListMailer.send_to_list(List.all).deliver
    redirect_to :users, notice: 'Test Mails send'
  end
end
