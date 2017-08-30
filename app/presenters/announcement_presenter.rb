class AnnouncementPresenter < BasePresenter
  def sorting_handle
    if current_holder.can?(:edit, @model)
      h.content_tag(:i, "", class: "handle fa fa-sort ui-sortable-handle", "aria-hidden" => "true")
    end
  end

  def display_name
    @model.name.truncate(38)
  end

  def as_list_item
    h.content_tag_for(:li, @model, class: "list-group-item") { yield }
  end
end
