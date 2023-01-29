
class SearchController < ApplicationController
  before_action :authenticate_user!

  def create
    @discussions = Discussion.where('name ILIKE ?', "%#{params[:title_search]}%").order(created_at: :desc)
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
  
  
