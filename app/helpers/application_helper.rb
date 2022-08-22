module ApplicationHelper
  def current_user
    User.first
  end

  def current_user?(user)
    current_user.id == user.id
  end

  def root_page?
    current_page?(root_path)
  end
end
