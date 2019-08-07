module Consul
  class Status
    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/status"
    end

    # get_leader returns the Raft leader for the datacenter in which the agent is running
    def get_leader() : String
      resp = HTTP::Client.get("#{base_url}/leader")
      return resp.body
    end

    # list_raft_peers retrieves the Raft peers for the datacenter in which the the agent is running
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