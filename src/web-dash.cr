require "./web-dash/*"
require "kemal"
require "kemal-basic-auth"
require "yaml"
basic_auth "cyan101", "pass123"
Cfg = YAML.parse(File.read("config.yaml"))

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
