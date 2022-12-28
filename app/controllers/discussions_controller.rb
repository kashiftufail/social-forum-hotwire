class DiscussionsController < ApplicationController
 
  before_action :set_discussion, only: [:edit, :destroy, :update]

  before_action :authenticate_user!  

  def index
    @discussions = Discussion.all
  end 

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to discussions_path, notice: "Discussion created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to discussions_path, notice: "Discussion updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: 'Discussion has removed'
  end

  private

  def discussion_params
    params.require(:discussion).permit(:name, :closed, :opened)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

end    