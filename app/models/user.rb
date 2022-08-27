# User class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def admin?
    role == 'admin'
  end

  def author_photo
    photo.blank? ? 'user.png' : photo
  end

  def all_posts
    posts.includes([:author]).order(created_at: :desc)
  end

  def recent_posts
    all_posts.limit(3)
  end
end
