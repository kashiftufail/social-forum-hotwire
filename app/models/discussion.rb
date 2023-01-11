class Discussion < ApplicationRecord
  
  has_many :articles, dependent: :destroy

  belongs_to :category, counter_cache: true, touch: true


  belongs_to :user, default: -> { Current.user }

  validates :name , presence:  true

  accepts_nested_attributes_for :articles

  


  after_create_commit -> { broadcast_prepend_to 'discussions'}
  after_update_commit -> { broadcast_replace_to 'discussions'}
  after_destroy_commit -> { broadcast_remove_to 'discussions'}
  
  def to_param
    "#{id}-#{name.downcase.to_s[0..90]}".parameterize
  end

end
