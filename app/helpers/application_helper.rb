module ApplicationHelper
  def map_if(controller, action)
    current_page?(controller:, action:) ? '' : 'px-5'
  end
end
