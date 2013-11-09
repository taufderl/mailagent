class FeedbackController < ApplicationController
  
  def new
    authorize! :feedback, :new
  end
  
  def create
    authorize! :feedback, :create
    feedback = params[:feedback]
    
    if feedback[:subject].empty? || feedback[:content].empty? 
      flash.now[:error] = t('feedback.field_empty')
      render action: :new
    else
      
      FeedbackMailer.send_email(@current_user.name_with_email, feedback[:content], feedback[:subject]).deliver
    
      redirect_to :dashboard, notice: t('feedback.thank')
    end
  end
end
