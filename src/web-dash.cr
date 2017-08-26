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

# Below is Updated HTML for Javascript to just replace on the current page

get "/update/cpu" do |env|
  Cpu.new
  info = ""
  info += "<p>Max CPU: #{Cpu.max}</p>"
  info += "<p class='mincpu inline'>Min </p><p class='inline'>CPU: #{Cpu.min}</p>"
  info += "<p>CPU Usage: #{Cpu.usage}% </p>"
end

get "/update/bar-cpu" do |env|
  "#{Cpu.usage}%"
end

get "/update/memory" do |env|
  Memory.new
  info = ""
  info += "<p>#{Memory.total} Total</p>"
  info += "<p>#{Memory.free} Free</p>"
  info += "<p>#{Memory.avail} Available</p>"
end

get "/update/bar-memory" do |env|
  mem_info = Memory.get_mem_info
  "#{(mem_info["MemFree"].to_f / mem_info["MemTotal"].to_f) * 100}%"
end

get "/update/top" do |env|
  top_info = `top -bn1`.split("\n")
  info = "<pre>#{top_info[0...20].join("\n")}</pre>"
end

Kemal.run unless ENV["travis_build"]?.to_s == "true"
