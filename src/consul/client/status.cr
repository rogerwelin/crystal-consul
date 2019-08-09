require "../util"

module Consul
  class Status

    getter client

    def initialize(@client : HTTP::Client)
    end

    # get_leader returns the Raft leader for the datacenter in which the agent is running
    def get_leader() : String
      resp = Consul::Util.get(client, "/v1/status/leader")
      return resp.body
    end

    # list_raft_peers retrieves the Raft peers for the datacenter in which the the agent is running
    def list_raft_peers(datacenter : String? = nil) : Array(String)
      url = "/v1/status/peers"

      unless datacenter.nil?
        url = "#{url}?dc=#{datacenter}"
      end

      resp  = Consul::Util.get(client, "#{url}")
      peers = Array(String).from_json(resp.body)
      return peers
    end

  end
end