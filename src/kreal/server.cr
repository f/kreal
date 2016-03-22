ws "/kreal" do |socket|
  socket.on_message do |message|
    event, id, data = message.split ":", 3
    data = JSON.parse data
    case event
    when "fetch"
      models = $KREAL.keys
      methods = [] of Array(String | Symbol)
      models.each do |model|
        $KREAL[model].shared.each do |method|
          methods << [model, method]
        end
      end
      data = {id: id, fetch: methods}
      socket.send data.to_json
    when "call"
      begin
        result = $KREAL[data["model"].to_s].call(data["method"], data["args"].as_a).to_s
      rescue e
        if e.to_s == "Index out of bounds"
          result = "Possibly not enough arguments for #{data["model"]}\##{data["method"]}\n\nException: #{e.inspect_with_backtrace}"
        else
          result = e.inspect_with_backtrace
        end
      end
      data = {id: id, call: {result: result}}
      socket.send data.to_json
    end
  end
end
