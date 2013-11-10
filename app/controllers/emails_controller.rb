class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /emails
  def index
    if params[:clear_search]
      params[:q] = nil
    end
    @q = Email.search(params[:q])
    @emails = @q.result(distinct: true)
  end

  # DELETE /emails/1
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:user_id, :subject, :content, :list_ids => [])
    end
end
