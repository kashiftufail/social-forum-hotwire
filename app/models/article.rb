class Article < ApplicationRecord
  

  belongs_to :discussion, counter_cache: true, touch: true
  
  belongs_to :user , default: -> {Current.user}
  
  has_rich_text :content

  validates :content , presence: true

end
