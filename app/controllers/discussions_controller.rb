class DiscussionsController < ApplicationController
 
  before_action :set_discussion, only: [:show ,:edit, :destroy, :update,:like_dislike,:vote_up_down]

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
    @up_votes = @discussion.up_votes
    @down_votes = @discussion.down_votes    
    @new_article = @discussion.articles.new
  end  

  def vote_up_down
    
    status = params[:status]
    @discussion.vote_up_down_actions(@discussion,status)
    
      @liked = @discussion.liked?
      @likes_count = @discussion.likes_count
      @up_votes = @discussion.up_votes
      @down_votes = @discussion.down_votes
      
    
         
      render turbo_stream: [
              turbo_stream.update("like_dislike",
              partial: "discussions/header",
              locals: { discussion: @discussion })
            ]
    
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
    # test = @discussion.like_dislike_actions(@discussion)
    # binding.pry
    # ppppppppppp

    if @discussion.like_dislike_actions(@discussion)
    
      @liked = @discussion.liked?
      @likes_count = @discussion.likes_count
      @up_votes = @discussion.up_votes
      @down_votes = @discussion.down_votes
      
      render turbo_stream: [
              turbo_stream.update("like_dislike",
              partial: "discussions/header",
              locals: { discussion: @discussion })
            ]
     else
       render :show, status: :unprocessable_entity
     end        
  end   

  private

  def discussion_params
    params.require(:discussion).permit(:name, :category_id, :closed, :opened,articles_attributes: :content)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

end    

