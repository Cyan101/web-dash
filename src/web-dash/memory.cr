class Memory
  class_getter total = ""
  class_getter free = ""
  class_getter avail = ""

  def initialize
    mem = Memory.get_mem_info
    mem_total = mem["MemTotal"].to_f
    @@total = (mem_total / 1024) > 1024 ? ((mem_total / 1024) / 1024).round(2).to_s + " GB" : (mem_total / 1024).round(2).to_s + " MB"
    mem_free = mem["MemFree"].to_f
    @@free = (mem_free / 1024) > 1024 ? ((mem_free / 1024) / 1024).round(2).to_s + " GB" : (mem_free / 1024).round(2).to_s + " MB"
    mem_avail = mem["MemAvailable"].to_f
    @@avail = (mem_avail / 1024) > 1024 ? ((mem_avail / 1024) / 1024).round(2).to_s + " GB" : (mem_avail / 1024).round(2).to_s + " MB"
  end

  def self.get_mem_info
    mem_info = {} of String => UInt64
    mem_file = File.read("/proc/meminfo").gsub(/\:|kb/i, "")
    mem_file.each_line do |line|
      item, kb = line.split
      mem_info[item] = kb.to_u64
    end
    return mem_info
  end
end
