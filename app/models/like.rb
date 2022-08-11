# Like class
class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  # adding "counter_cache: true" to the previous line automatically
  # increments the counter, and no longer is necessary the update_likes_count method
  after_save :update_likes_count

  private

  def update_likes_count
    post.increment!(:likes_count)
  end
end
