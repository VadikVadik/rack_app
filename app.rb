class App

  def call(env)
    @query = env["QUERY_STRING"]
    @path = env["REQUEST_PATH"]
    @user_format = (Rack::Utils.parse_nested_query(@query)).values.join.split(",")
    @acceptable_format = %w(year month day hour minute second)
    [status, headers, body]
  end

  def status
    if @path == "/time" && acceptable_format?
      200
    elsif @path == "/time"
      400
    else
      404
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    if @path == "/time" && acceptable_format?
      convert_format
    elsif @path == "/time"
      ["Unknown time format: #{unknown_format}"]
    else
      ["Page noy found"]
    end
  end

  def convert_format
    @user_format.map! do |i|
      case i
      when "year"
        Time.now.year
      when "month"
        Time.now.month
      when "day"
        Time.now.day
      when "hour"
        Time.now.hour
      when "minute"
        Time.now.min
      when "second"
        Time.now.sec
      end
    end
    [@user_format.join('-')]
  end

  def acceptable_format?
    (@user_format - @acceptable_format).empty?
  end

  def unknown_format
    @user_format - @acceptable_format
  end

end
