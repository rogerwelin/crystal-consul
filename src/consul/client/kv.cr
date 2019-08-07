require "base64"
require "../types/*"

module Consul
  class KV

    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/kv"
    end

    def get_key(path : String) : Consul::Types::KV::KvType
      resp = HTTP::Client.get("#{base_url}/#{path}")
      kv = Array(Consul::Types::KV).from_json(resp.body)
      keyval = Consul::Types::KV::KvType.new(kv.first.key, Base64.decode_string(kv.first.value))
      return keyval
    end

    def create_key(path : String, content : String)
      resp = HTTP::Client.put("#{base_url}/#{path}", body: content)
      puts resp.status_code
    end

    def delete_key(path : String)
      resp = HTTP::Client.delete("#{base_url}/#{path}")
      puts resp.status_code
    end

  end
end
