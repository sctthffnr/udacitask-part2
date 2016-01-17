module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(*args)
    # format_date being used by the Todo Class
    if args.length == 1
      return args[0] ? args[0].strftime("%D") : "No due date"
    end

    # format_date being used by the Event Class
    if args.length == 2
      dates = @start_date.strftime("%D") if @start_date
      dates << " -- " + @end_date.strftime("%D") if @end_date
      dates = "N/A" if !dates
      return dates
    end
  end

  def format_priority
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
  end
end
