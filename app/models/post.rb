# Post class
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: 'post_id', dependent: :delete_all
  has_many :comments, foreign_key: 'post_id', dependent: :delete_all

  # adding "counter_cache: true" to the previous line automatically increments
  # the counter, and no longer is necessary the update_posts_count method
  after_save :increment_posts_count
  after_destroy :decrement_posts_count

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def all_comments
    comments.includes([:author]).order(created_at: :desc)
  end

  def recent_comments
    all_comments.limit(5)
  end

  def fulltext(short: false)
    short ? "#{text[0..150]}..." : text
  end

  private

  def increment_posts_count
    author.increment!(:posts_count)
  end

  def decrement_posts_count
    author.decrement!(:posts_count)
  end
end
