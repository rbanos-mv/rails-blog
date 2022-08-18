module PostHelper
  def with_comments?(post)
    post.comments_count.positive? && !current_page?(user_path(post.author.id))
  end

  def short_text?(post)
    !current_page?(user_post_path(post.author.id, post.id))
  end
end
