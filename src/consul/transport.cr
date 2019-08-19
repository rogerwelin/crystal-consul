require "http/client"
require "./util"

module Consul
  class Transport
    getter client, consistency

    def initialize(@client : HTTP::Client, @consistency = "default")
    end

    def get_consistency : String
      return consistency
    end

    def get(path : String) : HTTP::Client::Response
      resp = client.get(path)
      Consul::Util.validate_response(resp)
      return resp
    end

    def delete(path : String) : HTTP::Client::Response
      resp = client.delete(path)
      Consul::Util.validate_response(resp)
      return resp
    end

    def put(path : String, data : JSON::Any) : HTTP::Client::Response
      resp = client.put(path, body: data)
      Consul::Util.validate_response(resp)
      return resp
    end

    # overloading put method
    def put(path : String, data : String) : HTTP::Client::Response
      resp = client.put(path, body: data)
      Consul::Util.validate_response(resp)
      return resp
    end

    # overloading put method
    def put(path : String) : HTTP::Client::Response
      resp = client.put(path)
      Consul::Util.validate_response(resp)
      return resp
    end
  end
end
