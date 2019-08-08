require "../types/*"
require "../util"

module Consul
  class Catalog

    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/catalog"
    end

    # register is a low-level mechanism for registering or updating entries in the catalog. 
    # It is usually preferable to instead use the agent endpoints for registration as they are simpler and perform anti-entropy
    def register(
        node : String, 
        address : String,
        id : String? = nil,
        datacenter : String? = nil,
        service = {} of String => String,
        check = {} of String => String,
        node_meta = {} of String => String
        )

        data = {"Node" => node, "Address" => address}

        unless id.nil?
          data["ID"] = id
        end

        unless datacenter.nil?
          data["Datacenter"] = datacenter
        end

        unless service.empty?
          data = data.merge({"Service" => service})
        end

        unless check.empty?
          data = data.merge({"Check" => check})
        end

        unless node_meta.empty?
          data = data.merge({"NodeMeta" => service})
        end

        puts data.to_json

        begin
          resp = Consul::Util.put("#{base_url}/register", data: data.to_json)
          #puts resp.status_code
          puts resp.body
        rescue ex
          puts ex
        end
    end

    # deregister is a low-level mechanism for directly removing entries from the Catalog. 
    # It is usually preferable to instead use the agent endpoints for deregistration as they are simpler and perform anti-entropy
    def deregister(
        node : String,
        datacenter : String? = nil,
        check_id : String? = nil,
        service_id : String? = nil?)

        data = {"Node" => node}

        unless datacenter.nil?
            data = data.merge({"Datacenter" => datacenter})
        end

        unless check_id.nil?
          data = data.merge({"CheckID" => check_id})
        end

        unless service_id.nil?
          data = data.merge({"ServiceID" => service_id})
        end

        resp = Consul::Util.put("#{base_url}/deregister", data: data.to_json)
        puts resp.status_code
    end

    # list_services returns the services registered in a given datacenter
    def list_services() : JSON::Any
        resp = Consul::Util.get("#{base_url}/services")
        return JSON.parse(resp.body)
    end

    # list_nodes_for_service returns the nodes providing a service in a given datacenter
    def list_nodes_for_service(service : String) : Array(Consul::Types::NodeService)
        resp  = Consul::Util.get("#{base_url}/service/#{service}")
        nodes = Array(Consul::Types::NodeService).from_json(resp.body)
        return nodes
    end

    # list_services_for_node returns the node's registered services
    def list_services_for_node()
    end

    # list_datacenters returns the list of all known datacenters. 
    # The datacenters will be sorted in ascending order based on the estimated median 
    # round trip time from the server to the servers in that datacenter
    def list_datacenters() : Array(String)
        resp = Consul::Util.get("#{base_url}/datacenters")
        dc = Array(String).from_json(resp.body)
    end

    # list_nodes returns the nodes registered in a given datacenter
    def list_nodes() : Array(Consul::Types::Node)
      resp  = Consul::Util.get("#{base_url}/nodes")
      nodes = Array(Consul::Types::Node).from_json(resp.body)
      return nodes
    end

  end
end