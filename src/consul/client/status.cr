require "../httpagent"

module Consul
  class Status < Consul::HttpAgent
    # get_leader returns the Raft leader for the datacenter in which the agent is running
    def get_leader : String
      resp = get("/v1/status/leader")
      return resp.body
    end

    # get_raft_peers retrieves the Raft peers for the datacenter in which the the agent is running
    def get_raft_peers(datacenter : String? = nil) : Array(String)
      url = "/v1/status/peers"

      unless datacenter.nil?
        url = "#{url}?dc=#{datacenter}"
      end

      resp = get(url)
      peers = Array(String).from_json(resp.body)
      return peers
    end
  end
end
