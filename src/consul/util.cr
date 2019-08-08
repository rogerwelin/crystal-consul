require "http/client"
require "./error"

module Consul
  module Util
    extend self

    def get(path : String) : HTTP::Client::Response
      resp = HTTP::Client.get(path)
      validate_response(resp)
      return resp
    end

    def delete(path : String) : HTTP::Client::Response
      resp = HTTP::Client.delete(path)
      validate_response(resp)
      return resp
    end

    def put(path : String, data : JSON::Any) : HTTP::Client::Response
      resp = HTTP::Client.put(path, body: data)
      validate_response(resp)
      return resp
    end

    # overloading put method
    def put(path : String, data : String) : HTTP::Client::Response
      resp = HTTP::Client.put(path, body: data)
      validate_response(resp)
      return resp
    end

    # overloading put method
    def put(path : String) : HTTP::Client::Response
      resp = HTTP::Client.put(path)
      validate_response(resp)
      return resp
    end

    private def validate_response(resp : HTTP::Client::Response)
      case resp.status_code
      when 400 then raise Consul::Error::BadRequest.new(resp)
      when 401 then raise Consul::Error::Unauthorized.new(resp)
      when 403 then raise Consul::Error::Forbidden.new(resp)
      when 408 then raise Consul::Error::RequestTimeout.new(resp)
      when 404 then raise Consul::Error::NotFound.new(resp)
      when 413 then raise Consul::Error::PayloadTooLarge.new(resp)
      when 500 then raise Consul::Error::InternalServerError.new(resp)
      end
    end
      
  end
end