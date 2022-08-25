# Comment class
class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  # adding "counter_cache: true" to the previous line automatically
  # increments the counter, and no longer is necessary the update_comments_count method
  after_save :increment_comments_count
  after_destroy :decrement_comments_count

  private

  def increment_comments_count
    post.increment!(:comments_count)
  end

  def decrement_comments_count
    post.decrement!(:comments_count)
  end
end
