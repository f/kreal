require "kemal"
require "dyncall"
require "coffee-script"
require "./kreal/*"

_kreal = nil
macro kreal(*models)
  _kreal = {
  {% for model in models %}
  "{{model.id}}": {{model.id}},
  {% end %}
  }
end

path = File.exists?("./libs/kreal") ? "./libs/kreal" : "./src"

macro debug_kreal
  path = File.exists?("./libs/kreal") ? "./libs/kreal" : "./src"
  debugger = File.read("#{path}/static/debugger.html")
  get "/kreal" do
    debugger
  end
end

client = CoffeeScript.compile(File.read("#{path}/static/kreal.coffee"), { bare: true })

get "/scripts/kreal.js" do |env|
  env.response.content_type = "application/javascript"
  client
end

ws "/kreal" do |socket|
  socket.on_message do |message|
    event, id, data = message.split ":", 3
    data = JSON.parse data
    case event
    when "fetch"
      models = _kreal.not_nil!.keys
      methods = [] of Array(String | Symbol)
      models.each do |model|
        _kreal.not_nil![model].shared.each do |method|
          methods << [model, method]
        end
      end
      data = {id: id, fetch: methods}
      socket.send data.to_json
    when "call"
      data = {id: id, call: {result: _kreal.not_nil![data["model"].to_s].call(data["method"], data["args"].as_a).to_s}}
      socket.send data.to_json
    end
  end
end

if Kemal.config.env == "development"
  debug_kreal
end

