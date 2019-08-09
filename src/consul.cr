require "./consul/*"

module Consul
  VERSION = "0.1.0"

  # shortcut for Consul::Client
  def self.client(
    host    : String = "127.0.0.1", 
    port    : Int32 = 8500,
    scheme  : String = "http",
    token    : String = "") : Consul::Client
    Consul::Client.new(host, port, scheme, token)
  end
end
