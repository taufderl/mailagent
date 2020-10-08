class SessionController < ApplicationController
  skip_authorization_check
  
  def new
    if current_user
      redirect_to :dashboard
    end
  end

  def create
    if params[:login]
      user = User.find_by_email(params[:login][:email].downcase)
      if user and user.admin? and user.authenticate(params[:login][:password])
        session[:user] = user.id
        redirect_to :dashboard, notice: t('session.login_succeeded')
      else
        redirect_to start_url, alert: t('session.wrong_credentials')
      end
    end
  end

  def destroy
    session[:user] = nil
    redirect_to start_url, notice: t('session.logout_succeeded')
  end
end
