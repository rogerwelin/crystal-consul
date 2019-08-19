require "base64"
require "../types/*"
require "../httpagent"

module Consul
  class KV < Consul::HttpAgent

    # get_key returns the specified key. If no key exists at the given path, a 404 is returned instead of a 200 response
    def get_key(path : String) : Consul::Types::KV::KvPair
      resp   = get("/v1/kv/#{path}")
      kv     = Array(Consul::Types::KV::KV).from_json(resp.body)
      keyval = Consul::Types::KV::KvPair.new(kv.first.key, Base64.decode_string(kv.first.value))
      return keyval
    end

    # overload get_key
    def get_key(path : String, recurse : Bool) : Array(Consul::Types::KV::KvPair)
      resp   = get("/v1/kv/#{path}?recurse=true")
      kv     = Array(Consul::Types::KV::KV).from_json(resp.body)
      keyvals = [] of Consul::Types::KV::KvPair
      kv.each do |kvpair|
        keyvals << Consul::Types::KV::KvPair.new(kvpair.key, Base64.decode_string(kvpair.value))
      end
      return keyvals
    end

    # create_key creates or updates an key. The return value is either true or false,
    # indicating whether the create/update succeeded
    def create_key(path : String, content : String)
      put("/v1/kv/#{path}", data: content)
    end

    # delete_key deletes a single key or all keys sharing a prefix
    def delete_key(path : String)
      delete("/v1/kv/#{path}")
    end

  end
end
