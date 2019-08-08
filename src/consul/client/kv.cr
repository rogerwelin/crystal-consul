require "base64"
require "../types/*"
require "../util"

module Consul
  class KV

    getter endpoint, port, base_url

    def initialize(@endpoint : String, @port : Int32)
        @base_url = "http://#{endpoint}:#{port}/v1/kv"
    end

    # get_key returns the specified key. If no key exists at the given path, a 404 is returned instead of a 200 response
    def get_key(path : String) : Consul::Types::KV::KvPair
      resp   = Consul::Util.get("#{base_url}/#{path}")
      kv     = Array(Consul::Types::KV).from_json(resp.body)
      keyval = Consul::Types::KV::KvPair.new(kv.first.key, Base64.decode_string(kv.first.value))
      return keyval
    end

    # create_key creates or updates an key. The return value is either true or false,
    # indicating whether the create/update succeeded
    def create_key(path : String, content : String)
      resp = Consul::Util.put("#{base_url}/#{path}", data: content)
      puts resp.status_code
    end

    # delete_key deletes a single key or all keys sharing a prefix
    def delete_key(path : String)
      resp = Consul::Util.delete("#{base_url}/#{path}")
      puts resp.status_code
    end

  end
end
