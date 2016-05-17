module ApplicationHelper
  def show_fields(record, fields, options={})
    klass = options.delete(:class) || record.class

    fields.map do |field|
      raw content_tag(:p,
        content_tag(:strong, "#{klass.human_attribute_name(field)}") << ": #{record.try(field)}"
      )
    end.reduce :<<
  end
end
