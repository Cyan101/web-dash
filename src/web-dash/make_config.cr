unless File.exists?("config.yaml")
  puts "No config found, creating config.yaml"
  hash_cfg = {"background" => "http://i.imgur.com/ea9PB3H.png", "title" => "Web-Dash", "favicon" => "images/favicon.png",
              "plex" => ":32400/web", "sonarr" => ":8989/", "radarr" => ":7878/", "transmission" => ":9091/"}
  File.write("config.yaml", hash_cfg.to_yaml)
end
