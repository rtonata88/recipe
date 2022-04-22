module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'bg-gray-900' : ''
  end

  def active_link(link_path)
    current_page?(link_path)
  end
end
