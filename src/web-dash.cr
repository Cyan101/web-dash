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

def get_mem_info
  mem_info = {} of String => UInt64
  mem_file = File.read("/proc/meminfo").gsub(/\:|kb/i, "")
  mem_file.each_line do |line|
    item, kb = line.split
    mem_info[item] = kb.to_u64
  end
  return mem_info
end

module Cpu
  class_getter usage = 0
  class_getter prev_idle = 0
  class_getter prev_total = 0

  def self.update_usage
    cpu = `cat /proc/stat`.gsub(/cpu/, "").strip.split("\n")
    cpu_stat = cpu[0].split(" ").map { |x| x.to_i }
    idle = cpu_stat[3]
    total = 0
    4.times { |x| total += cpu_stat[x] }

    diff_idle = idle - @@prev_idle
    diff_total = total - @@prev_total
    diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
    @@usage = diff_usage
    @@prev_idle = idle
    @@prev_total = total
    sleep(1)
  end

  spawn do
    loop do
      Cpu.update_usage
    end
  end
end

1.times do
  sleep 1
  Cpu.usage
end

Kemal.run
