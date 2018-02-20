module IconHelper

  def fa_icon(name = 'flag', options = {})
    content_tag(:i, nil, options.merge(class: "fa fa-#{name}", "aria-hidden": true))
  end

end