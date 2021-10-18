require_relative 'time_formatter'

class App

  def call(env)
    @query = env["QUERY_STRING"]
    @path = env["REQUEST_PATH"]
    @body = TimeFormatter.new(@query)
    response
  end

  def status
    if @path == "/time" && @body.acceptable_format?
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
    if @path == "/time" && @body.acceptable_format?
      @body.convert_format
    elsif @path == "/time"
      ["Unknown time format: #{@body.unknown_format}"]
    else
      ["Page noy found"]
    end
  end

  def response
    Rack::Response.[](status, headers, body).finish
  end

end
