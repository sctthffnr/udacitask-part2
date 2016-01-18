class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    verify_type(type.downcase)
    # Only verify priority if a priority value has been passed to the method
    options[:priority] && verify_priority(options[:priority])
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize if (index >= @items.length)
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  private

  def verify_type(type)
    valid_types = ["todo", "event", "link"]
    raise UdaciListErrors::InvalidItemType unless valid_types.include?(type)
  end

  def verify_priority(priority)
    valid_priorities = ["low", "medium", "high"]
    raise UdaciListErrors::InvalidPriorityValue unless valid_priorities.include?(priority)
  end
end
