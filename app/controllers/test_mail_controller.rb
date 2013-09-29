class TestMailController < ApplicationController
  def new
    ListMailer.send_to_list(List.all).deliver
    redirect_to :users, notice: 'Test Mails send'
  end
end
