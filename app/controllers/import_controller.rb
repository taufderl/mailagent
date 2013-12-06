class ImportController < ApplicationController
  require 'roo'
  
  # show index page with imort options
  def index
    authorize! :import, :index
  end
  
  # import new users without assigning a list to them
  def new_users 
    authorize! :import, :new_users
    
    if params[:new_users] ## file upload -> do validation
      if !(file = params[:new_users][:file])
        flash.now[:alert] = "Bitte wähle eine Datei."
        render :index
        return
      end

      begin
        @sheet = open_spreadsheet file
      rescue Exception => e
        flash.now[:alert] = "e.message"
        render :index
        return
      end
      
      @users = []
      
      @sheet.drop(1).each do |line|
        u = User.new(first_name: line[0], name: line[1], email: line[2].downcase)
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
      redirect_to import_url
    end
  end # end new_users
  
  # assign lists to existing users
  def assign_lists
    authorize! :import, :upload
    
    if params[:assign_lists] ## file upload -> do validation
      if !(file = params[:assign_lists][:file])
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
      
      @sheet.drop(1).each do |line|
        u = User.find_by_email(line[0].downcase)
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
    else
      redirect_to import_url
    end
  end # end assign_lists


  # Generic import, creates on behalf users
  def generic_import
    authorize! :import, :generic_import
    if params[:generic_import] ## file upload -> do validation
      if !(file = params[:generic_import][:file])
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
      
      @users = []
      @lists = []
      @subscriptions = []
      
      @sheet.drop(1).each do |line|
        # try to find user
        user = User.find_by_email(line[2].downcase)
        # try to find list
        list = List.find_by_name(line[3])
        
        if (user && list)# if both found
          # create new subscription
          s = Subscription.find_by(user: user, list: list)
          if s
            # nothing  
          else
            @subscriptions << {user: user.email,list: list.name}
          end 
        elsif (user) # if user exists
          # and list not empty
          if !(line[3] == nil || line[3] == '')
            # create new list, then subscription
            @lists << list = List.new(name: line[3])
            @subscriptions << {user: user.email,list: list.name}
          end
        elsif (list) # if list exists
          # create new user, then subscription
          @users << user = User.new(first_name: line[0], name: line[1], email: line[2].downcase)
          @subscriptions << {user: user.email,list: list.name}
        elsif # if nothing exists
          # create user
          @users << user = User.new(first_name: line[0], name: line[1], email: line[2].downcase)
          
          if !(line[3] == nil || line[3] == '') # and if list not empty also list
            # create all
            @lists << list = List.new(name: line[3])
            @subscriptions << {user: user.email,list: list.name}
          end
        end
        
        @users.uniq! {|u| u.email}
        @lists.uniq! {|l| l.name}
       
      end
    elsif params[:confirm]
      
      list_params = JSON.parse params[:lists]
      user_params = JSON.parse params[:users]
      subscription_params = JSON.parse params[:subscriptions]
      
      
      @lists = []
      @users = []
      @subscriptions = []
      
      successful_saved = 0
      
      list_params.each do |params|
        x = List.new params
        @lists << x
        if x.save
          successful_saved += 1
        end
      end
      
      user_params.each do |params|
        x = User.new params
        @users << x
        if x.save
          successful_saved += 1
        end
      end
      
      subscription_params.each do |subscription|
        x = Subscription.new(user: User.find_by_email(subscription['user']), list: List.find_by_name(subscription['list']))
        @subscriptions << x
        if x.save
          successful_saved += 1
        end
      end
      
      n = @subscriptions.count + @users.count + @lists.count
      
      flash.now[:notice] = "Import abgeschlossen. #{successful_saved} von #{n} Datensätzen erfolgreich importiert."
      render :index
    else
      redirect_to import_url
    end
    
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
