module ApplicationHelper
  def authorized?
    session[:access_token].present?
  end
end
