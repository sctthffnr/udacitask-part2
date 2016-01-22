class UdaciList
  attr_reader :title, :items

  def initialize(options = {})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options = {})
    type = type.downcase
    verify_type(type)
    verify_priority(options[:priority]) if options[:priority]
    @items.push TodoItem.new(description, type, options) if type == 'todo'
    @items.push EventItem.new(description, type, options) if type == 'event'
    @items.push LinkItem.new(description, type, options) if type == 'link'
  end

  def delete(index)
    fail IndexExceedsListSize if index >= @items.length
    @items.delete_at(index - 1)
  end

  def all(type = '')
    rows = gather_details(type)
    puts Terminal::Table.new(title: @title, rows: rows)
  end

  def gather_details(type)
    rows = []
    # TODO: put position # back in somehow
    @items.each do |item|
      if type == ''
        rows.push item.details
      elsif item.type == type
        rows.push item.details
      end
    end
    rows
  end

  def filter(type)
    all(type)
  end

  def find_todo(description)
    items.each do |item|
      return item if item.description == description
    end
  end

  def change_priority(todo, priority)
    verify_priority(priority)
    result = find_todo(todo)
    result.priority = priority
  end

  def change_due_date(todo, date)
    result = find_todo(todo)
    result.due = Chronic.parse(date)
  end

  private

  def verify_type(type)
    valid_types = %w(todo event link)
    fail UdaciList::InvalidItemType unless valid_types.include?(type)
  end

  def verify_priority(priority)
    valid_priorities = %w(low medium high)
    unless valid_priorities.include?(priority)
      fail UdaciList::InvalidPriorityValue
    end
  end
end
