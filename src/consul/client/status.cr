require "../util"

module Consul
  class Status
    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/status"
    end

    # get_leader returns the Raft leader for the datacenter in which the agent is running
    def get_leader() : String
      resp = Consul::Util.get("#{base_url}/leader")
      return resp.body
    end

    # list_raft_peers retrieves the Raft peers for the datacenter in which the the agent is running
    def list_raft_peers(datacenter : String? = nil) : Array(String)
      url = "#{base_url}/peers"

      unless datacenter.nil?
        url = "#{url}?dc=#{datacenter}"
      end

      resp = Consul::Util.get("#{url}")
      peers = Array(String).from_json(resp.body)
      return peers
    end

  end
end