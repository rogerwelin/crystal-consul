require "./client/*"
require "./agent/*"
require "json"
require "http/client"

module Consul
  class Client

    getter host, port
    getter kv, catalog, status, agent

    def initialize(
      @host   : String = "127.0.0.1", 
      @port   : Int32 = 8500,
      scheme  : String = "http"
      )

      @kv      = Consul::KV.new(host, port)
      @catalog = Consul::Catalog.new(host, port)
      @status  = Consul::Status.new(host, port)
      @agent   = Consul::Agent.new(port)
    end

  end
end
