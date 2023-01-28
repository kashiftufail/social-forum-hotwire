class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_article_notification.subject
  #
  def new_article_notification
    
    @user = params[:recipient]
    @article = params[:article]

    mail(to: @user.email, subject: "There's been a new reply in #{@article.discussion.name}.")
  
  end
end
