class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @subscriptions = Subscription.joins(:user).where(list: @list).order('LOWER(users.name)')
    respond_to do |format|
      
      format.csv do 
        data = CSV.generate do |csv|
          # TODO: make more generic
          csv << ['Vorname', 'Nachname', 'Email', 'Liste']
          @subscriptions.each do |subscr|
            csv << [subscr.user.first_name, subscr.user.name, subscr.user.email, subscr.list.name]
          end
        end
        send_data data, filename: "#{@list.name}.csv"
      end
      
      format.html
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render action: 'show', status: :created, location: @list }
      else
        format.html { render action: 'new' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_path, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
    end
  end
  
  def export
    @subscriptions = Subscription.includes(:user).where(list: @list)
    
    
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name)
    end
end
