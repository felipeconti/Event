class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :like, :dislike]

  before_action :valid_super_user, only: [:new, :edit, :destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        sync_new @poll
        format.html { redirect_to polls_url, notice: 'Poll was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poll }
      else
        format.html { render action: 'new' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        sync_update @poll
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy

    sync_destroy @poll

    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  def like
    @poll.liked_by current_user
    sync_update @poll
    redirect_to :back, notice: "Thank you for like!"
  end

  def dislike
    @poll.disliked_by current_user
    sync_update @poll
    redirect_to :back, notice: "Thank you for dislike!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def valid_super_user
      if not current_user.super_user
        flash[:notice] = "Oops! You can not access this path."
        redirect_to polls_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:description, :complement)
    end
end