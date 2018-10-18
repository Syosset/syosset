class SyossetRenderer < Redcarpet::Render::HTML
  def table(header, body)
    '<table class="table">' \
      "<thead>#{header}</thead>" \
      "<tbody>#{body}</tbody>" \
    '</table>'
  end

  def image(link, title, alt)
    alt = Azure::CognitiveServices.alt_description(link) if alt.nil?
    "<img class=\"img-fluid\" src=\"#{link}\" title=\"#{title}\" alt=\"#{alt}\">"
  end

  def block_quote(quote)
    "<blockquote class=\"blockquote\">#{quote}</blockquote>"
  end
end
