require "json"

module Consul
  module Types

    class KV
      JSON.mapping(
        key:    {type: String, key: "Key"},
        value:  {type: String, key: "Value"},
      )

      struct KvPair
        getter key, value

        def initialize(@key : String, @value : String)
        end
      end
    end

    class Node
      JSON.mapping(
        id:               {type: String, key: "ID"},
        node:             {type: String, key: "Node"},
        address:          {type: String, key: "Address"},
        datacenter:       {type: String, key: "Datacenter"},
        tagged_addresses: {type: Hash(String, String), key: "TaggedAddresses", nilable: true},
        meta:             {type: Hash(String, String), key: "Meta", nilable: true}
      )
    end

    class NodeService
      JSON.mapping(
        id:               {type: String, key: "ID"},
        node:             {type: String, key: "Node"},
        address:          {type: String, key: "Address"},
        datacenter:       {type: String, key: "Datacenter"},
        tagged_addresses: {type: Hash(String, String), key: "TaggedAddresses", nilable: true},
        node_meta:        {type: Hash(String, String), key: "NodeMeta", nilable: true},
        service_id:       {type: String, key: "ServiceID"},
        service_name:     {type: String, key: "ServiceName"},
        service_tags:     {type: Array(String), key: "ServiceTags", nilable: true},
        service_address:  {type: String, key: "ServiceAddress"},
        service_meta:     {type: Hash(String, String), key: "ServiceMeta"},
        service_port:     {type: Int32, key: "ServicePort"},
      )
    end

  end
end