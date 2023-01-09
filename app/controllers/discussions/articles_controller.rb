module Discussions
    class ArticlesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_discussion
  
      def create
        @article = @discussion.articles.new(article_params)
  
        respond_to do |format|
          if @article.save
            format.html { redirect_to discussion_path(@discussion), notice: "article created" }
          else
            format.turbo_stream
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
  
      private
  
      def set_discussion
        @discussion = Discussion.find(params[:discussion_id])
      end
  
      def article_params
        params.require(:article).permit(:content)
      end
    end
  end