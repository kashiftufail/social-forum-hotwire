class Discussion < ApplicationRecord
  
  belongs_to :user, default: -> { Current.user }

  validates :name , presence:  true

  def to_param
    "#{id}-#{name.downcase.to_s[0..90]}".parameterize
  end

end
