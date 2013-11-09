class DashboardController < ApplicationController
  
  def index
    authorize! :dashboard, :index
    @emails = Email.all
    @users = User.all.includes(:emails)
    @lists = List.all.includes(:users, :emails)
    
    @number_of_lists = @lists.count
    @number_of_emails = @emails.count
    @number_of_users = @users.count
    
    
    @users_by_emails = @users.select {|u| u.number_of_emails > 0}.sort_by {|u| u.number_of_emails}.reverse
    
    @lists_by_users = @lists.select {|l| l.number_of_users > 0}.sort_by {|l| l.number_of_users}.reverse
    
    @lists_by_emails = @lists.select {|l| l.number_of_emails > 0}.sort_by {|l| l.number_of_emails}.reverse
    
    
  end
end
