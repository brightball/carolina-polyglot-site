require "kemal"
require "json"
require "db"
require "pg"
require "uri"

db_uri = URI.new "postgres",
  ENV.fetch("DB_HOST", "127.0.0.1"),
  ENV.fetch("DB_PORT", "5432").to_i,
  ENV["DB_NAME"],
  nil,
  ENV.fetch("DB_USERNAME", "postgres"),
  ENV["DB_PASSWORD"]

get "/ping" do |env|
  DB.open db_uri do |db|
    {
      db_version: db.scalar("select version()").as(String),
    }.to_json
  end
end

before_all do |env|
  env.response.content_type = "application/json"
  env.response.headers["X-Backend"] = "crystal-kemal"
end

Kemal.run
