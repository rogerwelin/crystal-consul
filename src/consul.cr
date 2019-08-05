require "./consul/*"

module Consul
  VERSION = "0.1.0"

  def self.client(endpoint : String, port : Int) : Client
    Consul::Client.new(endpoint, port)
  end
end
