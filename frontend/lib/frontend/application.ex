defmodule Frontend.Application do
  use Application

  def start(_type, _args) do
    Bandit.start_link(plug: Frontend.Plug)
    Process.sleep(:infinity)
  end
end

defmodule Frontend.Plug do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    response = Req.get!(
      url: "http://traefik/ping",
      headers: [{"accept", "application/json"}]
    )

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "#{response.headers["x-backend"]} connected to #{response.body["db_version"]}")
  end
end
