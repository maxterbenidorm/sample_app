module ApplicationHelper
  
  # Retorna un título para la página HTML
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil? then
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
