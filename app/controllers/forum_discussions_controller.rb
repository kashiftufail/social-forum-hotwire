class ForumDiscussionsController < ApplicationController
 
  before_action :authenticate_user!  

  def index
    @discussions = ForumDiscussion.all
  end 

end    