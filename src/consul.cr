require "./consul/*"

module Consul
  VERSION = "0.1.0"

  # shortcut for Consul::Client
  def self.client(host : String, port : Int) : Client
    Consul::Client.new(host, port)
  end
end
