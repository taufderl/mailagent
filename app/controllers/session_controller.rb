class SessionController < ApplicationController
  
  def new
    if current_user
      redirect_to users_url
    end
  end

  def create
    if params[:login]
      user = User.find_by_email(params[:email])
      if user and user.authenticate(params[:password])
        session[:user] = user
        redirect_to :users
      else
        redirect_to start_url, alert: 'Wrong email or password.'
      end
    elsif params[:signup]
      #TODO: find User, if exists mail login link, if not create and mail profile link
       redirect_to start_url, alert: 'Signup not yet implemented.'
    else
      redirect_to start_url, alert: 'something happened.'
    end
  end

  def destroy
    session[:user] = nil
    redirect_to start_url, notice: 'Logout successful.'
  end
end
