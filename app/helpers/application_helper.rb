module ApplicationHelper
  def active_controller(controller, action = nil)
    return 'active' if params[:controller] == controller && (action ? params[:action] == action : true)
  end

  def svg(name)
    file_path = Rails.root.join('app', 'assets', 'images', "#{name}.svg")
    return File.read(file_path).html_safe if File.exist?(file_path)
    '(not found)'
  end

  def bootstrap_alert_class(flash_key)
    case flash_key
    when 'notice'
      'info'
    when 'alert'
      'danger'
    else
      flash_key
    end
  end

  def errors_for(object)
    return unless object.errors.any?

    content_tag(:div, class: 'panel panel-danger') do
      concat(content_tag(:div, class: 'panel-heading') do
        concat(content_tag(:h4, class: 'panel-title') do
          concat "#{pluralize(object.errors.count, 'error')} prohibited this #{object.class.name.downcase}
            from being saved:"
        end)
      end)
      concat(content_tag(:div, class: 'panel-body') do
        concat(content_tag(:ul) do
          object.errors.full_messages.each do |msg|
            concat content_tag(:li, msg)
          end
        end)
      end)
    end
  end

  def diff(content1, content2)
    changes = Diffy::Diff.new(content1, content2,
                              include_plus_and_minus_in_html: true,
                              include_diff_info: true)
    changes.to_s.present? ? changes.to_s(:html).html_safe : 'No Changes'
  end
end
