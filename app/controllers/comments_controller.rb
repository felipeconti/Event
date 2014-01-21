class CommentsController < ApplicationController

  before_action :find_trip
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  #before_action :valid_super_user, only: [:new, :edit, :destroy]
  enable_sync only: [:create, :update, :destroy]

  def index
    @comments = @trip.comments.all
  end

  def show
    flash[:notice] = "Not implemented yet"
    redirect_to @trip #Temporario
  end

  def new
    @comment = @trip.comments.new
  end

  def edit
    flash[:notice] = "Not implemented yet"
    redirect_to @trip #Temporario
  end

  def create
    @comment = @trip.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @trip
  end

  def update
    @comment.update(comment_params)
    redirect_to @trip
  end

  def destroy
    @comment.destroy
    redirect_to @trip
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_comment
    @comment = @trip.comments.find(params[:id])
  end

  def valid_super_user
    unless current_user.super_user
      flash[:notice] = t("oops_not_access")
      redirect_to trip_url
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:title, :message)
  end
end
