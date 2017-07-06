module ApplicationHelper
  def resource
    @resource ||= User.new
  end

  def resource_name
    :user
  end

  def resource_class
    User
  end

  def circle_img(url, size = 50)
    content_tag(:div, '', class: 'circle cover', style: "height: #{size}px;
                width: #{size}px; background-image: url(#{url});
                box-shadow: 0px 1px 5px #3f51b5;")
  end
end
