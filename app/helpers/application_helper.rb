module ApplicationHelper
  def page_title
    content_for(:title) || 'My Default Title'
  end

  def page_heading(page_title)
    content_for(:title) { page_title }
  end
end
