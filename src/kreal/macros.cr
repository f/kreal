macro kreal(*models)
  $KREAL = {
  {% for model in models %}
  "{{model.id}}" => {{model.id}},
  {% end %}
  }
end

macro debug_kreal
  path = File.exists?("./libs/kreal") ? "./libs/kreal" : "./src"
  debugger = File.read("#{path}/static/debugger.html")
  get "/kreal" do
    debugger
  end
end

