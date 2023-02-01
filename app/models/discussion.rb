class Discussion < ApplicationRecord
  
  acts_as_votable
 
  validates :name , presence:  true
  
  has_many :articles, dependent: :destroy


  has_many :users, through: :articles
  
  has_many :subscriptions, dependent: :destroy
  
  has_many :opted_subscribers, -> { where(subscriptions: { subscription_type: :opted }) },
    through: :subscriptions,
    source: :user
  
    has_many :optout_subscribers, -> { where(subscriptions: { subscription_type: :optout }) },
    through: :subscriptions,
    source: :user


  belongs_to :category, counter_cache: true, touch: true


  belongs_to :user, default: -> { Current.user }

  scope :filter_by_name, -> (name) { where('name ILIKE ?', "%#{name}%") }
  
  scope :display_opened_first, -> { order(opened: :desc, updated_at: :desc) }

  delegate :name, prefix: :category, to: :category, allow_nil: true   

  accepts_nested_attributes_for :articles  
  
  broadcasts_to :category, inserts_by: :prepend

  after_create_commit -> { broadcast_prepend_to 'discussions'}
  after_update_commit -> { broadcast_replace_to 'discussions'}
  after_destroy_commit -> { broadcast_remove_to 'discussions'}
  
  def to_param
    "#{id}-#{name.downcase.to_s[0..90]}".parameterize
  end

  def subscribed_users
    (users + opted_subscribers).uniq - optout_subscribers
  end

  def subscription_for(user)
    return nil if user.nil?
    Subscription.find_by(user_id: user.id)
  end

  def subscribed?(user)
    return false if user.nil?

    if subscription = subscription_for(user)
      subscription.subscription_type == "opted"
    else
      articles.where(user_id: user.id).any?
    end
  end

  def toggle_subscription(user)
    if subscription = subscription_for(user)
      subscription.toggle!
    elsif articles.where(user_id: user.id).any?
      subscriptions.create(user: user, subscription_type: "optout")
    else
      subscriptions.create(user: user, subscription_type: "opted")
    end
  end


  def subscribed_reason(user)
    return "You're not receiving notifications from this thread" if user.nil?

    if subscription = subscription_for(user)
      if subscription.subscription_type == "optout"
        "You're ignoring this thread."
      elsif subscription.subscription_type == "opted"
        "You're receiving notifications because you've subscribed to this thread."
      end
    elsif articles.where(user_id: user.id).any?
      "You're receiving notifications because you've posted in this thread."
    else
      "You're not receiving notifications from this thread"
    end
  end

  def like_dislike_actions(discussion)
    discussion.liked? ? (discussion.unliked_by Current.user) : (discussion.liked_by Current.user)
      
    # else  
      
    # end    
  end
  
  def liked?
    Current.user.liked? self
  end  

  def likes_count 
    self.get_likes.size
  end  

end
