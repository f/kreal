require "kemal"
require "dyncall"
require "coffee-script"
require "./kreal/*"

macro kreal(*models)
  KREAL = {
  {% for model in models %}
  "{{model.id}}": {{model.id}}
  {% end %}
  }
end

macro debug_kreal
  debugger = File.read("./libs/kreal/static/debugger.html")
  get "/kreal" do
    debugger
  end
end

client = CoffeeScript.compile(File.read("./libs/kreal/static/kreal.coffee"), { bare: true })

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
      models = KREAL.keys
      methods = [] of Array(String | Symbol)
      models.each do |model|
        KREAL[model].shared.each do |method|
          methods << [model, method]
        end
      end
      data = {id: id, fetch: methods}
      socket.send data.to_json
    when "call"
      data = {id: id, call: {result: KREAL[data["model"].to_s].call(data["method"], data["args"].as_a).to_s}}
      socket.send data.to_json
    end
  end
end

# debug_kreal
#
# class Hello
#   share :world
#   def self.world(args)
#     "hello world!"
#   end
# end
#
# kreal Hello
#
# Kemal.run
