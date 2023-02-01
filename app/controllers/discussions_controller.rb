class DiscussionsController < ApplicationController
 
  before_action :set_discussion, only: [:show ,:edit, :destroy, :update,:like_dislike]

  before_action :authenticate_user!  

  def index
    @pagy , @discussions = pagy(Discussion.includes(:category).display_opened_first)
  end 

  def new
    @discussion = Discussion.new
    @discussion.articles.new
  end

  def show
    @pagy , @articles = pagy(@discussion.articles.includes(:user, :rich_text_content).order(created_at: :desc))
    @liked = @discussion.liked?
    @likes_count = @discussion.likes_count
    @new_article = @discussion.articles.new
  end  

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      
      
      
      if @discussion.save
        format.html { redirect_to @discussion, notice: "Discussion created" }
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
        DiscussionBroadcaster.new(@discussion).broadcast!

        format.html { redirect_to @discussion, notice: "Discussion updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: 'Discussion has removed'
  end

  def like_dislike
    @discussion.like_dislike_actions(@discussion)
    @liked = @discussion.liked?
    @likes_count = @discussion.likes_count
    
    render turbo_stream: [
            turbo_stream.update("like_dislike",
            partial: "discussions/header",
            locals: { discussion: @discussion })
          ]
  end   

  private

  def discussion_params
    params.require(:discussion).permit(:name, :category_id, :closed, :opened,articles_attributes: :content)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

end    

