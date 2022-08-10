# Comment class
class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  # adding "counter_cache: true" to the previous line automatically
  # increments the counter, and it is not necessary the update_comments_count method
  after_save :update_comments_count

  private

  def update_comments_count
    post.increment!(:comments_count)
  end
end
