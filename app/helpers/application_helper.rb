module ApplicationHelper
  def authorized?
    session[:access_token].present?
  end

  def flash_class(type)
    case type
    when 'success' then 'bg-green-100 border border-green-400 text-green-700'
    when 'alert' then 'bg-red-100 border border-red-400 text-red-700'
    else 'bg-gray-100 border border-gray-400 text-gray-700'
    end
  end
end
