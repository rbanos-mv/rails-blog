# Post class
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  # adding "counter_cache: true" to the previous line automatically increments
  # the counter, and no longer is necessary the update_posts_count method
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'
  after_save :update_posts_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_count
    author.increment!(:posts_count)
  end
end
