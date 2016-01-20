class LinkItem
  include Listable
  attr_reader :description, :site_name, :type

  def initialize(url, type, options = {})
    @description = url
    @site_name = options[:site_name]
    @type = type
  end

  def format_name
    @site_name ? @site_name : ' '
  end

  def details
    [format_description(@description), type, "site name: #{format_name}", '']
  end
end
