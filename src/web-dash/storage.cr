# Move above devices to a Config

def get_storage
  devices = Cfg["storage"]

  df = `df`.split("\n")
  devices_info = [] of String

  begin
    df.each do |x|
      mount_location = x.split(/\s{1,}/)[5]
      devices_info << x if devices.includes?(mount_location)
    end
  rescue
    puts "Error reading/finding some devices"
  end

  return devices_info
end

# Array 0 -> 5 Info
# Filesystem 1K-blocks Used Available Use% Mounted-on

def kb_to_size(size : Float | Int, round : Int? = 2)
  key = 0
  sizes = %w(KB MB GB TB)
  while size > 1024
    key += 1
    size = size / 1024
  end
  return [size.round(round), sizes[key]]
end
