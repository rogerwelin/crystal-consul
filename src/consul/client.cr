require "./client/**"
require "json"
require "http/client"

module Consul
  class Client

    getter endpoint, port
    getter kv, catalog, status

    def initialize(@endpoint : String, @port : Int32)
      @kv = Consul::KV.new(endpoint, port)
      @catalog = Consul::Catalog.new(endpoint, port)
      @status = Consul::Status.new(endpoint, port)
    end

  end
end
