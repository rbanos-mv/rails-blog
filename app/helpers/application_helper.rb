module ApplicationHelper
  def current_user?(user_id)
    current_user.id == user_id
  end
end
