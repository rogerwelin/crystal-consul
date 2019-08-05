require "./client/**"
require "json"
require "http/client"

module Consul
  class Client
    include KV

    getter endpoint, port
    getter kv

    def initialize(@endpoint : String, @port : Int32)
      @kv = Consul::Client::KV
    end

    def apa
      puts port
    end

  end
end
