require "./web-dash/*"
require "kemal"
require "kemal-basic-auth"
basic_auth "cyan101", "pass123"

before_all do |env|
  env.kemal_authorized_username? # Halt if fails
end

before_get do |env|
end

get "/" do |env|
  mem_info = get_mem_info
  render "src/dashboard.ecr"
end

Kemal.run

def get_mem_info
  mem_info = {} of String => UInt64
  mem_file = File.read("/proc/meminfo").gsub(/\:|kb/i, "")
  mem_file.each_line do |line|
    item, kb = line.split
    mem_info[item] = kb.to_u64
  end
  return mem_info
end
