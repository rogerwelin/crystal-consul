require "./client/*"
require "./agent/*"
require "json"
require "http/client"
require "uri"

module Consul
  class Client
    getter host, port, scheme, token, consistency
    getter kv, catalog, status, agent, event, health, coordinate
    getter snapshot

    def initialize(
      @host : String = "127.0.0.1",
      @port : Int32 = 8500,
      @scheme : String = "http",
      @token : String = "",
      @consistency : String = "default" # to be implemented
    )
      if consistency === "default" || consistency === "consistent" || consistency === "stale"
      else
        raise "Error: #{consistency} is not a valid consistency option"
      end

      client = http_client_instance("#{scheme}://#{host}:#{port}", token)

      @kv = Consul::KV.new(client)
      @catalog = Consul::Catalog.new(client)
      @status = Consul::Status.new(client)
      @agent = Consul::Agent.new(client)
      @event = Consul::Event.new(client)
      @health = Consul::Health.new(client)
      @coordinate = Consul::Coordinate.new(client)
      @snapshot = Consul::Snapshot.new(client)
    end

    private def http_client_instance(uri : String, token : String? = nil) : HTTP::Client
      uri = URI.parse(uri)
      client = HTTP::Client.new(uri)
      client.connect_timeout = 5

      unless token == ""
        client.before_request do |request|
          request.headers["X-Consul-Token"] = token
        end
      end

      return client
    end
  end
end
