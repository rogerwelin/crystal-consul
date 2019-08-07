require "../types/*"

module Consul
  class Catalog

    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/catalog"
    end

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
          resp = HTTP::Client.put("#{base_url}/register", body: data.to_json)
          #puts resp.status_code
          puts resp.body
        rescue ex
          puts ex
        end
    end

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

        resp = HTTP::Client.put("#{base_url}/deregister", body: data.to_json)
        puts resp.status_code
    end

    def list_services() : JSON::Any
        resp = HTTP::Client.get("#{base_url}/services")
        return JSON.parse(resp.body)
    end

    def list_nodes_for_service()
    end

    def list_services_for_node()
    end

    def list_datacenters() : JSON::Any
        resp = HTTP::Client.get("#{base_url}/datacenters")
        return JSON.parse(resp.body)
    end

    def list_nodes() : Array(Consul::Types::Node)
      resp = HTTP::Client.get("#{base_url}/nodes")
      nodes = Array(Consul::Types::Node).from_json(resp.body)
      return nodes
    end

  end
end