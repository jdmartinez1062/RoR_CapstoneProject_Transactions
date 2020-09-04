module ApplicationHelper
  def page_title
    content_for(:title) || 'My Default Title'
  end

  def page_heading(page_title)
    content_for(:title) { page_title }
  end

  def set_page
    @page = params[:page]
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_id
    @id = params[:id]
  end
end
