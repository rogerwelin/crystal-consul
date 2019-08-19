require "../transport"
require "../util"

module Consul
  class Snapshot < Consul::Transport
    # create_snapshot generates and returns an atomic, point-in-time snapshot of the Consul server state.
    # Snapshots are exposed as gzipped tar archives which internally contain the Raft metadata required to restore,
    # as well as a binary serialized version of the Consul server state
    def create_snapshot(datacenter : String? = nil) : String
      endpoint = "/v1/snapshot"
      consistency = get_consistency()
      val = Consul::Util.build_query_params({
        "#{consistency}" => "",
        "dc"             => datacenter,
      })

      if val
        endpont = "#{endpoint}#{val}"
      end

      resp = get(endpoint)
      return resp.body
    end

    # restore_snapshot restores a point-in-time snapshot of the Consul server state
    def restore_snapshot(data : String, datacenter : String? = nil)
      unless dc.nil?
        put("/v1/snapshot?dc=#{datacenter}", data: data)
      else
        put("/v1/snapshot", data: data)
      end
    end
  end
end
