class ForumDiscussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :name , presence:  true

end
