module ApplicationHelper
  def current_user
    User.first
  end

  def current_user?(user_id)
    current_user.id == user_id
  end

  def root_page?
    current_page?(root_path)
  end
end
