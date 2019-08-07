require "json"

module Consul
  module Types
    class KV

      JSON.mapping(
        key: {type: String, key: "Key"},
        value: {type: String, key: "Value"},
      )

      struct KvType
        getter key, value

        def initialize(@key : String, @value : String)
        end
      end

    end

    class Node
      JSON.mapping(
        id: {type: String, key: "ID"},
        node: {type: String, key: "Node"},
        address: {type: String, key: "Address"},
        datacenter: {type: String, key: "Datacenter"},
        tagged_addresses: {type: Hash(String, String), key: "TaggedAddresses", nilable: true},
        meta: {type: Hash(String, String), key: "Meta", nilable: true}
      )
    end
  end
end