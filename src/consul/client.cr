require "./client/**"
require "json"
require "http/client"

module Consul
  class Client

    getter endpoint, port
    getter kv, catalog

    def initialize(@endpoint : String, @port : Int32)
      @kv = Consul::KV.new(endpoint, port)
      @catalog = Consul::Catalog.new(endpoint, port)
    end

  end
end
