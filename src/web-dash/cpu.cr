class Cpu
  class_getter usage = 0
  class_getter prev_idle = 0
  class_getter prev_total = 0
  class_getter max = ""
  class_getter min = ""

  def initialize
    max = `lscpu | grep -e "CPU max"`.split(":")[1].to_f
    @@max = max > 1000 ? (max / 1000).round(2).to_s + "Ghz" : max.round(2).to_s + "Mhz"
    min = `lscpu | grep -e "CPU min"`.split(":")[1].to_f
    @@min = min > 1000 ? (min / 1000).round(2).to_s + "Ghz" : min.round(2).to_s + "Mhz"
  end

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
