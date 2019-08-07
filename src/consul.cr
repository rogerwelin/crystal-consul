require "./consul/*"

module Consul
  VERSION = "0.1.0"

  # shortcut for Consul::Client
  def self.client(endpoint : String, port : Int) : Client
    Consul::Client.new(endpoint, port)
  end
end
