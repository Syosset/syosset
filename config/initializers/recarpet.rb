class BootstrapRenderer < Redcarpet::Render::HTML
  def table(header, body)
    "<table class=\"table table-responsive\">" \
      "<thead>#{header}</thead>" \
      "<tbody>#{body}</tbody>" \
    "</table>"
  end

  def image(link, title, alt)
    "<img class=\"img-responsive\" src=\"#{link}\" title=\"#{title}\" alt=\"#{alt}\">"
  end
end
