require "json"

module Consul
  class Check
    property name, id, interval, notes, deregister_critial_service_after, args
    property alias_node, alias_service, docker_container_id
    property grpc, grpc_use_tls, http, method, header, timeout, tls_skip_verify
    property tcp, ttl, service_id, status

    JSON.mapping(
      name: {type: String, key: "Name"},
      id: {type: String, key: "ID", nilable: true},
      interval: {type: String, key: "Interval", nilable: true},
      notes: {type: String, key: "Notes", nilable: true},
      deregister_critial_service_after: {type: String, key: "DeregisterCriticalServiceAfter", nilable: true},
      args: {type: Array(String), key: "Args", nilable: true},
      alias_node: {type: String, key: "AliasNode", nilable: true},
      alias_service: {type: String, key: "AliasSerice", nilable: true},
      docker_container_id: {type: String, key: "DockerContainerID", nilable: true},
      grpc: {type: String, key: "GRPC", nilable: true},
      grpc_use_tls: {type: Bool, key: "GRPCUseTLS", nilable: true},
      http: {type: String, key: "HTTP", nilable: true},
      method: {type: String, key: "Method", nilable: true},
      header: {type: Hash(String, Array(String)), key: "Header", nilable: true},
      timeout: {type: String, key: "Timeout", nilable: true},
      tls_skip_verify: {type: Bool, key: "TLSSkipVerify", nilable: true},
      tcp: {type: String, key: "TCP", nilable: true},
      ttl: {type: String, key: "TTL", nilable: true},
      service_id: {type: String, key: "ServiceID", nilable: true},
      status: {type: String, key: "Status", nilable: true},
    )

    def initialize(
      @name : String,
      @id : String? = nil,
      @interval : String? = nil,
      @notes : String? = nil,
      @deregister_critial_service_after : String? = nil,
      @args : Array(String)? = nil,
      @alias_node : String? = nil,
      @alias_service : String? = nil,
      @docker_container_id : String? = nil,
      @grpc : String? = nil,
      @grpc_use_tls : Bool = false,
      @http : String? = nil,
      @method : String? = nil,
      @header : Hash(String, Array(String))? = nil,
      @timeout : String = "10s",
      @tls_skip_verify : Bool = false,
      @tcp : String? = nil,
      @ttl : String? = nil,
      @service_id : String? = nil,
      @status : String? = nil
    )
    end
  end
end
