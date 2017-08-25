unless File.exists?("config.yaml")
  puts "No config found, creating config.yaml"
  hash_cfg = {"background" => "http://i.imgur.com/ea9PB3H.png", "title" => "Web-Dash", "favicon" => "images/favicon.png"}
  File.write("config.yaml", hash_cfg.to_yaml)
end
