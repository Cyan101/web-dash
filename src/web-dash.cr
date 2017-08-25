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
  render "src/dashboard.ecr"
end

Kemal.run
