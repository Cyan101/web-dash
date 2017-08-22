require "./web-dash/*"
require "kemal"
require "kemal-basic-auth"

basic_auth "cyan101", "pass123"

before_all do |env|
  env.kemal_authorized_username? # Halt if fails
end

before_get do |env|
  mem_info = `cat /proc/meminfo`.gsub(/(\ |(kb))/i, "").split("\n")
  env.set("free_mem", free_mem(mem_info))
  env.set("avail_mem", avail_mem(mem_info))
  env.set("total_mem", total_mem(mem_info))
end

get "/" do |env|
  page = ""
  page += "#{env.get("free_mem").as(String).to_i / 1024}MB Free<br>"
  page += "#{env.get("avail_mem").as(String).to_i / 1024}MB Available<br>"
  page += "#{env.get("total_mem").as(String).to_i / 1024}MB Total<br>"
end

Kemal.run

def free_mem(mem)
  mem[1].split(":").[1]
end

def avail_mem(mem)
  mem[2].split(":").[1]
end

def total_mem(mem)
  mem[0].split(":").[1]
end
