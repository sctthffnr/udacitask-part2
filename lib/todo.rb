class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, type, options = {})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @type = type
  end

  def details
    [format_description(@description), type, "due: #{format_date(@due)}",
     format_priority]
  end
end
