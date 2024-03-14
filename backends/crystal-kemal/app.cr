require "kemal"
require "json"
require "db"
require "pg"
require "uri"

get "/ping" do |env|
  env.response.content_type = "application/json"

  conn_uri = "postgres://backend:#{URI.encode_path ENV["DB_PASSWORD"]}@pgbouncer:6432/ccc"
  DB.open conn_uri do |db|
    {
      backend: "crystal-kemal",
      db_version: db.scalar("select version()").as(String),
    }.to_json
  end
end

Kemal.run
