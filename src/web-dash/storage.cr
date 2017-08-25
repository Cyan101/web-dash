# Move above devices to a Config

def get_storage
  devices = [] of String
  devices << "/media/removable/Alter/"
  devices << "/var/host/media/removable/Alter"
  devices << "/"

  df = `df`.split("\n")
  devices_info = [] of String
  begin
    df.each do |x|
      mount_location = x.split(/\s{1,}/)[5]
      devices_info << x if devices.includes?(mount_location)
    end
  rescue
    puts "Error reading some devices"
  end
  return devices_info
end

# Filesystem 1K-blocks Used Available Use% Mounted-on
# devices_info.each do |x|
#  x = x.split(/\s{1,}/)
#  puts "#{x[5]} is #{x[4]} (#{kb_to_size(x[2].to_f)}) used"
#  puts "Filesystem: #{x[0]}"
#  puts "Total Space: #{kb_to_size(x[2].to_f + x[3].to_f)}"
# end

def kb_to_size(size : Float | Int, round : Int? = 2)
  key = 0
  sizes = %w(kb mb gb tb)
  while size > 1024
    key += 1
    size = size / 1024
  end
  return "#{size.round(round)}#{sizes[key]}"
end
