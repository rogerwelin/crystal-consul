require "uri"
require "../util"

module Consul
  class Agent
    getter base_url

    def initialize(@port : Int32, @endpoint =  "")
        @base_url = "http://localhost:#{port}/v1/agent"
    end

    # get_services returns all the services that are registered with the local agent
    def get_services() : JSON::Any
      resp = Consul::Util.get("#{base_url}/services")

      return JSON.parse(resp.body)
    end

    # get_service_conf returns the full service definition for a single service instance registered on the local agent
    def get_service_conf(name : String) : Consul::Types::Agent::ServiceConf
      resp = Consul::Util.get("#{base_url}/service/#{name}")
      return Consul::Types::Agent::ServiceConf.from_json(resp.body)
    end

    # get_local_service_health returns an aggregated state of service(s) on the local agent by name
    def get_service_health(name : String) : Array(Consul::Types::Agent::ServiceHealth)
      resp = Consul::Util.get("#{base_url}/health/service/name/#{name}")
      return Array(Consul::Types::Agent::ServiceHealth).from_json(resp.body)
    end

    # register_service adds a new service, with an optional health check, to the local agent
    # TO-DO: implement kind, proxy, connect
    def register_service(
      name                : String,
      port                : Int32,
      id                  : String? = nil,
      tags                : Array(String)? = nil,
      address             : String? = nil,
      meta                : Hash(String, String)? = nil,
      check               : Hash(String, String | Array(String))? = nil,
      enable_tag_override : Bool = false,
      )

      data = {"Name" => name, "Port" => port, "EnableTagOverride" => enable_tag_override}

      unless id.nil?
        data["ID"] = id
      end

      unless address.nil?
        data["Address"] = address
      end

      unless tags.nil?
        data = data.merge({"Tags" => tags})
      end

      unless meta.nil?
        data = data.merge({"Meta" => meta})
      end

      unless check.nil?
        data = data.merge({"Check" => check})
      end

      Consul::Util.put("#{base_url}/service/register", data: data.to_json)
    end

    # deregister_service removes a service from the local agent. If the service does not exist, no action is taken
    def deregister_service(service_id : String)
      # service/deregister/my-service-id
      Consul::Util.put("#{base_url}/service/deregister/#{service_id}")
    end

    # set_serice_maintenence places a given service into "maintenance mode". 
    # During maintenance mode, the service will be marked as unavailable and will not be present in DNS or API queries
    def set_service_maintenenance(service_id : String, enable : Bool, reason = "")
      if reason != ""
        reason = URI.escape(reason)
        Consul::Util.put("#{base_url}/service/maintenance/#{service_id}?enable=#{enable}&reason=#{reason}")
      else
        Consul::Util.put("#{base_url}/service/maintenance/#{service_id}?enable=#{enable}")
      end
    end

    # get_checks returns all checks that are registered with the local agent. 
    def get_checks()
    end

    # register_check adds a new check to the local agent. Checks may be of script, HTTP, TCP, or TTL type. 
    # The agent is responsible for managing the status of the check and keeping the Catalog in sync
    def register_check(
      name                              : String,
      id                                : String? = nil,
      interval                          : String? = nil,
      notes                             : String? = nil,
      deregister_critial_service_after  : String? = nil,
      args                              : Array(String)? = nil,
      alias_node                        : String? = nil,
      alias_service                     : String? = nil,
      docker_container_id               : String? = nil,
      grpc                              : String? = nil,
      grpc_use_tls                      : Bool = false,
      http                              : String? = nil,
      method                            : String? = nil,
      header                            : Hash(String, Array(String))? = nil,
      timeout                           : String = "10s",
      tls_skip_verify                   : Bool = false,
      tcp                               : String? = nil,
      ttl                               : String? = nil,
      service_id                        : String? = nil,
      status                            : String? = nil,
      )

      data = {"Name" => name, "Timeout" => timeout, "TLSSkipVerify" => tls_skip_verify, "GRPCUseTLS" => grpc_use_tls}

      unless id.nil?
        data["ID"] = id
      end

      unless interval.nil?
        data["Interval"] = interval
      end

      unless notes.nil?
        data["Notes"] = notes
      end

      unless args.nil?
        data = data.merge({"Args" => args})
      end

      unless alias_node.nil?
        data["AliasNode"] = alias_node
      end

      unless alias_service.nil?
        data["AliasService"] = alias_service
      end

      unless docker_container_id.nil?
        data["DockerContainerID"] = docker_container_id
      end

      unless grpc.nil?
        data["GRPC"] = grpc
      end

      unless http.nil?
        data["HTTP"] = http
      end

      unless method.nil?
        data["Method"] = method
      end

      unless header.nil?
        data = data.merge({"Header" => header})
      end

      unless tcp.nil?
        data["TCP"] = tcp
      end

      unless ttl.nil?
        data["TTL"] = ttl
      end

      unless service_id.nil?
        data["ServiceID"] = service_id
      end

      unless status.nil?
        data["Status"] = service_id
      end


    end

    # deregister_check remove a check from the local agent. The agent will take care of deregistering the check from 
    # the catalog. If the check with the provided ID does not exist, no action is taken
    def deregister_check()
    end

    # ttl_check_pass is used with a TTL type check to set the status of the check to passing and to reset the TTL clock
    def ttl_check_pass(check_id : String, note : String? = nil)
    end

    # ttl_check_warn is used with a TTL type check to set the status of the check to warning and to reset the TTL clock
    def ttl_check_warn(check_id : String, note : String? = nil)
    end

    # ttl_check_fail is used with a TTL type check to set the status of the check to critical and to reset the TTL clock
    def ttl_check_fail(check_id : String, note : String? = nil)
    end

    # ttl_check_upate is used with a TTL type check to set the status of the check and to reset the TTL clock
    def ttl_check_update(check_id : String, note : String? = nil, output : String? = nil)
    end

  end
end
