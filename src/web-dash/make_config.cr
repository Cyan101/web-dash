unless File.exists?("config.yaml")
  puts "No config found, creating config.yaml"
  puts "Please edit this config file to change any options for the dashboard/server"
  hash_cfg = {"user" => "admin", "pass" => "password123", "address" => "127.0.0.1",
              "port" => 3000, "background" => "http://i.imgur.com/ea9PB3H.png",
              "title" => "Web-Dash", "favicon" => "images/favicon.png", "plex" => ":32400/web",
              "sonarr" => ":8989/", "radarr" => ":7878/", "transmission" => ":9091/",
              "storage" => ["/", "/media/removable/USB/"]}
  File.write("config.yaml", hash_cfg.to_yaml)
end
