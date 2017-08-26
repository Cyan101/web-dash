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
  info = ""
  info += "<p>Max CPU: "
  cpu = `lscpu | grep -e "CPU max"`.split(":")[1].to_f
  info += cpu > 1000 ? (cpu / 1000).round(2).to_s + "Ghz" : cpu.round(2).to_s + "Mhz"
  info += "</p>"
  info += "<p class='mincpu inline'>Min </p><p class='inline'>CPU: "
  cpu = `lscpu | grep -e "CPU min"`.split(":")[1].to_f
  info += cpu > 1000 ? (cpu / 1000).round(2).to_s + "Ghz" : cpu.to_i.to_s + "Mhz"
  info += "</p>"
  info += "<p>CPU Usage: #{Cpu.usage}% </p>"
end

get "/update/memory" do |env|
  mem_info = get_mem_info
  mem_total = mem_info["MemTotal"].to_f
  info = ""
  info += "<p>"
  info += (mem_total / 1024) > 1024 ? ((mem_total / 1024) / 1024).round(2).to_s + " GB" : (mem_total / 1024).round(2).to_s + " MB"
  info += " Total</p><p>"
  mem_free = mem_info["MemFree"].to_f
  info += (mem_free / 1024) > 1024 ? ((mem_free / 1024) / 1024).round(2).to_s + " GB" : (mem_free / 1024).round(2).to_s + " MB"
  info += " Free</p><p>"
  mem_avail = mem_info["MemAvailable"].to_f
  info += (mem_avail / 1024) > 1024 ? ((mem_avail / 1024) / 1024).round(2).to_s + " GB" : (mem_avail / 1024).round(2).to_s + " MB"
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
