class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include PgSearch::Model
  # pg_search_scope :search_by_name, against: :name
  # pg_search_scope :search_by_username, against: :username
  pg_search_scope :search, against: [:name, :username]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweeets, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
end
