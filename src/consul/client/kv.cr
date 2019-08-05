require "base64"
require "./types/*"

module Consul
    class Client
      module KV
      extend self

      struct KV2
        getter key, value

        def initialize(@key : String, @value : String)
        end
      end

      def get_key : KV2
        resp = HTTP::Client.get("http://localhost:8500/v1/kv/apa")
        kv = Array(Types::KV).from_json(resp.body)
        keyval = KV2.new(kv.first.key, Base64.decode_string(kv.first.value))
        return keyval
      end
    end
  end
end
