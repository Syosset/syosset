class DepartmentPresenter < BasePresenter
  def subscription_button
    unless current_user
      return h.link_to "Subscribe", new_user_registration_path
    end
    if @model.subscriber? h.current_user
      h.link_to "Unsubscribe", unsubscribe_department_path(@model), data: { method: 'post' }
    else
      h.link_to "Subscribe", subscribe_department_path(@model), data: { method: 'post' }
    end
  end


  def editable_content
    if current_holder.can? :edit, @model
      h.content_tag(:div, id: "department[content]", class: "editable-content") { yield }
    else
      yield
    end
  end
end
