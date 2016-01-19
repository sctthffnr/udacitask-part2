module Listable
  def format_description(description)
    description.ljust(30)
  end

  def format_date(*args)
    # format_date being used by the Todo Class
    return format_todo(args[0]) if args.length == 1

    # format_date being used by the Event Class
    return format_event(args[0], args[1]) if args.length == 2
  end

  def format_priority
    value = ' ⇧' if @priority == 'high'
    value = ' ⇨' if @priority == 'medium'
    value = ' ⇩' if @priority == 'low'
    value = ' ' unless @priority
    value
  end

  private

  def format_todo(due)
    due ? due.strftime('%D') : 'No due date'
  end

  def format_event(start_date, end_date)
    dates = start_date.strftime('%D') if start_date
    dates << ' -- ' + end_date.strftime('%D') if end_date
    dates = 'N/A' unless dates
    dates
  end
end
