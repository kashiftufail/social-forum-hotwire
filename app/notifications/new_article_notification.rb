# To deliver this notification:
#
# NewArticleNotification.with(post: @post).deliver_later(current_user)
# NewArticleNotification.with(article: Article.first).deliver(User.first)

class NewArticleNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :article

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end

  def message
    "New article in #{params[:article].discussion.name}"
  end

  def url
    discussion_path(params[:article].discussion)
  end



end
