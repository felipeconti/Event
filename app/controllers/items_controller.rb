class ItemsController < ApplicationController

  before_action :find_trip

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  before_action :valid_super_user, only: [:new, :edit, :destroy]

  enable_sync only: [:create, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = @trip.items.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = @trip.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = @trip.items.new(item_params)

    respond_to do |format|
      if @item.save
        # sync_new @item
        format.html { redirect_to trip_items_url, notice: t("successfully_created", :model => t("models.item")) }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        # sync_update @item
        format.html { redirect_to trip_items_url, notice: t("successfully_updated", :model => t("models.item")) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy

    # sync_destroy @item

    respond_to do |format|
      format.html { redirect_to trip_items_url }
      format.json { head :no_content }
    end
  end

  private

    def find_trip
      @trip = Trip.find(params[:trip_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @trip.items.find(params[:id])
    end

    def valid_super_user
      unless current_user.super_user
        flash[:notice] = t("oops_not_access")
        redirect_to trip_item_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :amount, :value)
    end
end
