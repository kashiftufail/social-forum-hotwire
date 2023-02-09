module DiscussionsHelper
  def likes_votes_count(discussion)
    @liked = discussion.liked?
    @likes_count = discussion.likes_count
    @up_votes = discussion.up_votes
    @down_votes = discussion.down_votes    
  end
end
