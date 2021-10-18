class TimeFormatter

  def initialize(format)
    @date = DateTime.now
    @user_format = (Rack::Utils.parse_nested_query(format)).values.join.split(",")
    @acceptable_format = { "year" => @date.strftime('%Y'),
                           "month" => @date.strftime('%m'),
                           "day" => @date.strftime('%d'),
                           "hour" => @date.strftime('%H'),
                           "minute" => @date.strftime('%M'),
                           "second" => @date.strftime('%S') }
  end

  def convert_format
    @user_format.map! do |i|
      @acceptable_format[i]
    end
    [@user_format.join('-')]
  end

  def acceptable_format?
    (@user_format - @acceptable_format.keys).empty?
  end

  def unknown_format
    @user_format - @acceptable_format.keys
  end

end
