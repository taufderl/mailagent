class ImportController < ApplicationController
  require 'roo'
  
  # show index page with imort options
  def index
    authorize! :import, :index
  end
  
  # import plain users without assigning a list to them
  def new_users 
    authorize! :import, :new_users
    
    if params[:upload] ## file upload -> do validation
      if !(file = params[:file])
        flash[:alert] = "Bitte wähle eine Datei."
        render :index
        return
      end

      begin
        @sheet = open_spreadsheet file
      rescue Exception => e
        flash[:alert] = e.message
        render :index
        return
      end
      
      @users = []
      
      @sheet.each do |line|
        u = User.new(first_name: line[0], name: line[1], email: line[2])
        @users << u
      end
    elsif params[:confirm]

      users_params = JSON.parse params[:users]
      @users = []
      successful_saved = 0
      users_params.each do |user_params|
        u = User.new user_params
        @users << u
        if u.save
          successful_saved += 1
        end
      end
      flash[:notice] = "Import abgeschlossen. #{successful_saved} von #{@users.count} Benutzern erfolgreich importiert."
      render :index
    else
      render :index 
    end
    
  end # end new_users
  
  # assign lists to existing users
  def assign_lists
    authorize! :import, :upload
    
    if params[:upload] ## file upload -> do validation
      if !(file = params[:file])
        flash.now[:alert] = "Bitte wähle eine Datei."
        render :index
        return
      end
      
      begin
        @sheet = open_spreadsheet file
      rescue Exception => e
        flash.now[:alert] = e.message
        render :index
        return
      end
      
      @subscriptions = []
      
      @sheet.each do |line|
        u = User.find_by_email(line[0])
        list = List.find_by_name(line[1])
        s = Subscription.new(user: u,list: list)
        @subscriptions << s
      end
    elsif params[:confirm] 
      
      subscription_params = JSON.parse params[:subscriptions]
      @subscriptions = []
      
      successful_saved = 0
      
      subscription_params.each do |s_params|
        s = Subscription.new s_params
        @subscriptions << s
        if s.save
          successful_saved += 1
        end
      end
      flash.now[:notice] = "Import abgeschlossen. #{successful_saved} von #{@subscriptions.count} Listenabonnements erfolgreich importiert."
      render :index
    end
  end # end assign_lists


  def upload
    authorize! :import, :upload
    
    if params[:upload] ## file upload -> do validation
      if !(file = params[:file])
        flash.now[:alert] = "Bitte wähle eine Datei."
        render :index
        return
      end
      
      
      if !(@list = List.find_by_id(params[:list_id]))
        flash.now[:alert] = "Bitte wähle eine Liste."
        render :index
        return
      end
      
      begin
        @sheet = open_spreadsheet file
      rescue Exception => e
        flash.now[:alert] = e.message
        render :index
        return
      end
      
      @users = []
      
      @sheet.each do |line|
        u = User.new(first_name: line[0], name: line[1], email: line[2])
        @users << u
      end
    elsif params[:confirm]
      
      @list = List.find(params[:list_id]) 
      
      users_params = JSON.parse params[:users]
      @users = []
      
      users_params.each do |user_params|
        u = User.new user_params
        @users << u
        @user.list = @list
        u.save
      end 
    end

  end
  
  
  def new_list
    # TODO  
  end
  
  
  private
  
  def open_spreadsheet(file) 
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    when ".ods" then Roo::OpenOffice.new(file.path, nil, :ignore)
    else raise "Kein gültiger Dateityp: #{file.original_filename}. Erlaubt sind: .csv .xls .xlsx oder .ods"
    end
  end
end
