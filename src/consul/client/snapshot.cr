require "../httpagent"

module Consul
  class Snapshot < Consul::HttpAgent

    # create_snapshot generates and returns an atomic, point-in-time snapshot of the Consul server state.
    # Snapshots are exposed as gzipped tar archives which internally contain the Raft metadata required to restore, 
    # as well as a binary serialized version of the Consul server state
    def create_snapshot(datacenter : String? = nil) : String
      resp = get("/v1/snapshot")
      return resp.body
    end

    # restore_snapshot restores a point-in-time snapshot of the Consul server state
    def restore_snapshot(data : String)
      put("/v1/snapshot", data: data) 
    end

  end
end