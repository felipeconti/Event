class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :request_participation]

  before_action :valid_super_user, only: [:new, :edit, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @users = @event.users

    unless current_user.super_user
      unless @users.include?(current_user)
        flash[:warning] = t("oops_not_access")
        redirect_to root_path
      end
    end
  end

  # GET /events/new
  def new
    @users = User.all
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @users = User.all
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id
    
    update_users

    respond_to do |format|
      if @event.save
        sync_new @event
        format.html { redirect_to events_url, notice: t("successfully_created", :model => t("models.event")) }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    #require "pry"; binding.pry

    update_users

    respond_to do |format|
      if @event.update(event_params)
        sync_update @event
        format.html { redirect_to @event, notice: t("successfully_updated", :model => t("models.event")) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    sync_destroy @event

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def request_participation
    @text = t("req_notification", user_name: current_user.name, event_name: @event.name)
    #require "pry"; binding.pry

    if Notification.where("user_id = #{@event.owner_id} and description = '#{@text}'").count == 0
      @notification = Notification.new
  
      @notification.user = User.find(@event.owner_id || 0)
      @notification.description = @text
      @notification.viewed = false
      @Ok = @notification.save
    else
      @Ok = true
    end

    if @Ok
      flash[:notice] = t("req_sended", event_name: @event.name)
    else
      flash[:notice] = t("req_error")
    end
    redirect_to root_path
  end
  
  private
  
    def update_users
      @event.users = User.find(params["users_ids"] || [])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def valid_super_user
      unless current_user.super_user
        flash[:error] = t("oops_not_access")
        redirect_to events_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description)
    end
end
