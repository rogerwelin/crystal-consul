require "./client/*"
require "./agent/*"
require "json"
require "http/client"
require "uri"

module Consul
  class Client

    getter host, port, scheme, token
    getter kv, catalog, status, agent, event

    def initialize(
      @host    : String = "127.0.0.1", 
      @port    : Int32 = 8500,
      @scheme  : String = "http",
      @token   : String? = nil    # to be implemented
      )

      client = http_client_instance("#{scheme}://#{host}:#{port}")

      @kv      = Consul::KV.new(client)
      @catalog = Consul::Catalog.new(client)
      @status  = Consul::Status.new(client)
      @agent   = Consul::Agent.new(client)
      @event   = Consul::Event.new(client)
    end

    private def http_client_instance(uri : String) : HTTP::Client
      uri = URI.parse(uri)
      client = HTTP::Client.new(uri)
      client.connect_timeout = 5
      return client
    end

  end
end
