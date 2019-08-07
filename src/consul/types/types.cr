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
  end
end