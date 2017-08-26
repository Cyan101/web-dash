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

get "/" do |env|
  render "src/dashboard.ecr"
end

get "/css/custom.css" do |env|
  env.response.headers["Content-Type"] = "text/css"
  "html { background-image: url('#{Cfg["background"]?.nil? || "" ? "http://i.imgur.com/ea9PB3H.png" : Cfg["background"]}')}"
end

get "/update/cpu" do |env|
  Cpu.new
  info = ""
  info += "<p>Max CPU: "
  info += Cpu.max
  info += "</p>"
  info += "<p class='mincpu inline'>Min </p><p class='inline'>CPU: "
  info += Cpu.min
  info += "</p>"
  info += "<p>CPU Usage: #{Cpu.usage}% </p>"
end

get "/update/memory" do |env|
  Memory.new
  info = ""
  info += "<p>"
  info += Memory.total
  info += " Total</p><p>"
  info += Memory.free
  info += " Free</p><p>"
  info += Memory.avail
  info += " Available</p>"
end

get "/update/top" do |env|
  info = ""
  info += "<pre>"
  top_info = `top -bn1`.split("\n")
  small_top = top_info[0...20].join("\n")
  info += "#{small_top}</pre>"
end

Kemal.run
