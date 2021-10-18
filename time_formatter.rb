class TimeFormatter

  def initialize(format)
    @date = DateTime.now
    @format = format
    @user_format
    @acceptable_format
    @unknown_format
  end

  def call
    @user_format = (Rack::Utils.parse_nested_query(@format)).values.join.split(",")
    @acceptable_format = { "year" => '%Y-',
                           "month" => '%m-',
                           "day" => '%d ',
                           "hour" => '%H:',
                           "minute" => '%M:',
                           "second" => '%S' }
    @unknown_format = @user_format - @acceptable_format.keys
  end

  def valid?
    @unknown_format.empty?
  end

  def time_string
    @user_format.map! do |i|
      @acceptable_format[i]
    end
    @date.strftime(@user_format.join(''))
  end

  def invalid_string
    "Unknown time format: #{@unknown_format}"
  end

end
