require "./consul/*"

module Consul
  VERSION = "0.1.3"

  # shortcut for Consul::Client
  def self.client(
    host : String = "127.0.0.1",
    port : Int32 = 8500,
    scheme : String = "http",
    token : String = "",
    consistency : String = "default"
  ) : Consul::Client
    Consul::Client.new(host, port, scheme, token, consistency)
  end
end
