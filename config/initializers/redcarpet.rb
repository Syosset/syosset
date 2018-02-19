class SyossetRenderer < Redcarpet::Render::HTML
  def table(header, body)
    '<table class="table table-responsive">' \
      "<thead>#{header}</thead>" \
      "<tbody>#{body}</tbody>" \
    '</table>'
  end

  def image(link, title, alt)
    alt = Azure::CognitiveServices.alt_description(link) if alt.nil?
    "<img class=\"img-responsive\" src=\"#{link}\" title=\"#{title}\" alt=\"#{alt}\">"
  end
end
