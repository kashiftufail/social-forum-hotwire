class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  acts_as_voter

  validates :username, presence: true, uniqueness: true

  has_many :discussions, dependent: :destroy

  has_many :articles, dependent: :destroy
  
  has_many :notifications, as: :recipient, dependent: :destroy


end
