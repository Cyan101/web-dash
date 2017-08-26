require "./web-dash/*"
require "kemal"
require "kemal-basic-auth"
require "yaml"
Cfg = YAML.parse(File.read("config.yaml"))
# logging false
Kemal.config.host_binding = Cfg["address"].to_s
Kemal.config.port = Cfg["port"].to_s.to_i
basic_auth Cfg["user"].to_s, Cfg["pass"].to_s

before_all do |env|
  env.kemal_authorized_username? # Halt if fails
end

before_get do |env|
end

get "/" do |env|
  render "src/dashboard.ecr"
end

get "/css/custom.css" do |env|
  env.response.headers["Content-Type"] = "text/css"
  "html { background-image: url('#{Cfg["background"]?.nil? || "" ? "http://i.imgur.com/ea9PB3H.png" : Cfg["background"]}')}"
end

Kemal.run
