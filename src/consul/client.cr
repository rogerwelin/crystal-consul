require "./client/*"
require "./agent/*"
require "json"
require "http/client"

module Consul
  class Client

    getter endpoint, port
    getter kv, catalog, status, agent

    def initialize(@endpoint : String, @port : Int32)
      @kv = Consul::KV.new(endpoint, port)
      @catalog = Consul::Catalog.new(endpoint, port)
      @status = Consul::Status.new(endpoint, port)
      @agent = Consul::Agent.new(port)
    end

  end
end
