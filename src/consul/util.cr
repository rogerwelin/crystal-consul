require "http/client"
require "./error"

module Consul
  module Util
    extend self

    # build url query parameters
    def validate_query_parameters(arg)
      valid = [] of String
      index = 0
      build_url = ""
    
      arg.each do |key, val|
        unless val.nil?
          valid << "#{key}=#{val}"
        end
      end
    
      if valid.empty?
        return false
      end
    
      if valid.size == 1
        return "?#{valid[0]}"
      else
        valid.each do |val|
          if index == 0
            build_url = "?#{val}"
          else
            build_url = "#{build_url}&#{val}"
          end
          index += 1
        end
      end
      return build_url
    end

    def validate_response(resp : HTTP::Client::Response)
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