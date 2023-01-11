class Article < ApplicationRecord
  

  belongs_to :discussion, counter_cache: true, touch: true
  
  belongs_to :user , default: -> {Current.user}
  
  has_rich_text :content

  validates :content , presence: true

  after_create_commit -> { broadcast_append_to discussion, partial: "discussions/articles/article", locals: { article: self }}
  after_update_commit -> { broadcast_replace_to discussion, partial: "discussions/articles/article", locals: { article: self }}
  after_destroy_commit -> { broadcast_remove_to discussion }


end
