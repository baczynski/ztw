module Rule
  extend ActiveSupport::Concern

  included do
    has_one :tournament, as: :rule
  end

  def initialize(attributes={}, options={})
    attributes = attributes.permit *permitted_params
    super
  end
  
  def desc
    send "desc_#{I18n.locale}"
  end

  class_methods do

    def rule_name
      send "rule_name_#{I18n.locale}"
    end
  end
end