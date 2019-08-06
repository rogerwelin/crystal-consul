module Consul
  class Status
    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/status"
    end

    def get_leader() : String
      resp = HTTP::Client.get("#{base_url}/leader")
      return resp.body
    end

    def list_raft_peers(datacenter : String? = nil) : JSON::Any
      url = "#{base_url}/peers"

      unless datacenter.nil?
        url = "#{url}?dc=#{datacenter}"
      end

      resp = HTTP::Client.get("#{url}")
      return JSON.parse(resp.body)
    end

  end
end