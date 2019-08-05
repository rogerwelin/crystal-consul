require "base64"
require "./types/*"

module Consul
  class Client
    module Kv
      struct KV
        getter key, value

        def initialize(@key : String, @value : String)
        end
      end

      def get_key : KV
        resp = HTTP::Client.get("http://localhost:8500/v1/kv/apa")
        kv = Array(Types::KV).from_json(resp.body)
        keyval = KV.new(kv.first.key, Base64.decode_string(kv.first.value))
        return keyval
      end
    end
  end
end
