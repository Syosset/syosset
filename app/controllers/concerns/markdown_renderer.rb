# Initializes a markdown renderer for use in views
module MarkdownRenderer
  extend ActiveSupport::Concern

  included do
    before_action :create_markdown_renderer
  end

  private

  def create_markdown_renderer
    @markdown = Redcarpet::Markdown.new(SyossetRenderer.new(filter_html: true), tables: true)
  end
end