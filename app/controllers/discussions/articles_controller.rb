module Discussions
    class ArticlesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_discussion
      before_action :set_article, only: [:show, :edit, :update,:destroy]

  
      def create
        @article = @discussion.articles.new(article_params)
  
        respond_to do |format|
          if @article.save
            send_article_notification!(@article)

            format.html { redirect_to discussion_path(@discussion), notice: "article created" }
          else
            format.turbo_stream
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def show
      end
  
      def edit
      end
  
      def update
        respond_to do |format|
          if @article.update(article_params)
            format.html { redirect_to @article.discussion, notice: "article update" }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        
        @article.destroy
  
        respond_to do |format|
          format.turbo_stream { }
          format.html { redirect_to @article.discussion, notice: "article deleted" }
        end
      end
  
      private

      def set_article
        @article = @discussion.articles.find(params[:id])
      end
  
      def set_discussion
        @discussion = Discussion.find(params[:discussion_id])
      end
  
      def article_params
        params.require(:article).permit(:content)
      end

      def send_article_notification!(article)
        article_subscribers = article.discussion.subscribed_users - [article.user]
        NewArticleNotification.with(article: article).deliver_later(article_subscribers)  
      end  

    end
  end