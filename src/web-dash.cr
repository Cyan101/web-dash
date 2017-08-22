require "./web-dash/*"
require "kemal"
require "kemal-basic-auth"

basic_auth "cyan101", "pass123"

get "/" do |env|
  "Hi, %s!" % env.kemal_authorized_username?
end

Kemal.run
