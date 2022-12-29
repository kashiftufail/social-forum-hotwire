class AddArticleCountsToDiscussion < ActiveRecord::Migration[7.0]
  def change
    add_column :discussions, :article_count, :integer, default: 0
  end
end
