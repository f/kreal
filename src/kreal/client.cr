path = File.exists?("./libs/kreal") ? "./libs/kreal" : "./src"
client = File.read("#{path}/static/kreal.js")

get "/scripts/kreal.js" do |env|
  env.response.content_type = "application/javascript"
  client
end

