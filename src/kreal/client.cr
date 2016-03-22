path = File.exists?("./libs/kreal") ? "./libs/kreal" : "./src"
client = CoffeeScript.compile(File.read("#{path}/static/kreal.coffee"), {bare: true, noHeader: true})

get "/scripts/kreal.js" do |env|
  env.response.content_type = "application/javascript"
  client
end

