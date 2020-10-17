class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    # Filter leeren
    if params[:clear_search]
      params[:q] = nil
    end
    @q = User.includes(:lists).ransack(params[:q])
    @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 100)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user == @current_user
      redirect_to edit_profile_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
     
    # generate pw
    pw = random_pw
    @user.password = pw
    @user.password_confirmation = pw
    
    respond_to do |format|
      if @user.save
        
        if @user.admin?
          # Send mail that contains password
          UserMailer.notify_new_admin(@user, pw).deliver
          # Notify owner about new admin
          DebugMailer.send_email(@user.inspect, t('notification.new_admin_created')).deliver
        end
        
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.assign_attributes(user_params)
    
    # if role changed to admin
    if @user.role_changed? && @user.admin?
      changed_to_admin = true
      pw = random_pw
      @user.password = pw
      @user.password_confirmation = pw
    end
    
    respond_to do |format|
      if @user.save
        
        if changed_to_admin
          # Send mail that contains password
          UserMailer.notify_new_admin(@user, pw).deliver
        end
        
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_back fallback_location: root_path, alert: "That didn't work" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  # GET /profile
  def profile
    # TODO: make sure @current_user is set
  end
  
  def edit_profile
    # TODO: make sure @current_user is set
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :name, :email, :password, :password_confirmation, :role, :list_ids => [])
  end
  
  def random_pw 
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(8) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
end
