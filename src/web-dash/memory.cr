def get_mem_info
  mem_info = {} of String => UInt64
  mem_file = File.read("/proc/meminfo").gsub(/\:|kb/i, "")
  mem_file.each_line do |line|
    item, kb = line.split
    mem_info[item] = kb.to_u64
  end
  return mem_info
end
