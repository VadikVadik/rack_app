require_relative 'time_formatter'

class App

  def call(env)
    if path_wrong?(env["REQUEST_PATH"])
      response(404, 'invalid path')
    else
      handle_params(env["QUERY_STRING"])
    end
  end

  def path_wrong?(path)
    path != "/time"
  end

  def handle_params(params)
    formatter = TimeFormatter.new(params)
    formatter.call
    if formatter.valid?
      response(200, formatter.time_string)
    else
      response(400, formatter.invalid_string)
    end
  end

  def response(status, body)
    Rack::Response.new(body, status, { 'Content-Type' => 'text/plain' }).finish
  end

end
