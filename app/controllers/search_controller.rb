
class SearchController < ApplicationController
  before_action :authenticate_user!

  def create

    if params.dig(:title_search).present?
      @discussions = Discussion.where('name ILIKE ?', "%#{params[:title_search]}%").order(created_at: :desc)
    else  
      @discussions = []
    end
      respond_to do |format|
      format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("search_results",
            partial: "discussions/search_results",
            locals: { discussions: @discussions })
          ]
      end
    end
  end
end
  
  
