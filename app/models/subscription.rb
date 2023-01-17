class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  scope :opted, -> { where(subscription_type: :opted) }
  scope :optout, -> { where(subscription_type: :optout) }

  validates :subscription_type, presence: true, inclusion: { in: %w[opted optout] }
  validates :user_id, uniqueness: { scope: :discussion_id }

  



end
