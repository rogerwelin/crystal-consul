require "base64"
require "./types/*"

module Consul
  class KV
    getter endpoint, port
    def initialize(@endpoint : String, @port : Int32)
    end

    struct KvType
      getter key, value

      def initialize(@key : String, @value : String)
      end
    end

    def get_key(path : String) : KvType
      resp = HTTP::Client.get("http://#{endpoint}:#{port}/v1/kv/#{path}")
      kv = Array(Types::KV).from_json(resp.body)
      keyval = KvType.new(kv.first.key, Base64.decode_string(kv.first.value))
      return keyval
    end
  end
end
