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
    if index.class == Fixnum
      delete_one_item(index)
    elsif index.class == Array
      delete_multiple_items(index)
    end
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

  def verify_index(index)
    fail IndexExceedsListSize if index >= @items.length
  end

  def delete_one_item(index)
    verify_index(index)
    @items.delete_at(index - 1)
  end

  def delete_multiple_items(indexes)
    # The counter is needed to delete the proper index number during each
    # interation, since the items in the list change index values when an
    # item is deleted
    counter = 0
    # The index array must be in order for the counter to work
    indexes.sort!
    indexes.each do |index|
      verify_index(index)
      @items.delete_at(index - counter - 1)
      counter += 1
    end
  end
end
