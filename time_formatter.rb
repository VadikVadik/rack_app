class TimeFormatter

  ACCEPTABLE_FORMAT = { "year" => '%Y-',
                         "month" => '%m-',
                         "day" => '%d ',
                         "hour" => '%H:',
                         "minute" => '%M:',
                         "second" => '%S' }

  def initialize(format)
    @format = format
    @user_format = ""
    @unknown_format = []
  end

  def call
    @user_format = (Rack::Utils.parse_nested_query(@format)).values.join.split(",")
    @unknown_format = @user_format - ACCEPTABLE_FORMAT.keys
  end

  def valid?
    @unknown_format.empty?
  end

  def time_string
    @user_format.map! do |i|
      ACCEPTABLE_FORMAT[i]
    end
    DateTime.now.strftime(@user_format.join(''))
  end

  def invalid_string
    "Unknown time format: #{@unknown_format}"
  end

end
