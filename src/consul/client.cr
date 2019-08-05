require "./client/**"
require "json"
require "http/client"

module Consul
  class Client
    getter endpoint, port

    def initialize(@endpoint : String, @port : Int32)
    end

    def apa
      puts port
    end

    include Kv
  end
end
