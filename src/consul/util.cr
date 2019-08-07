module Consul
  module Util

    def get(path : String) : HTTP::Response
    end

    def put(path : String, body : JSON::Any) : HTTP::Response
    end

    private def validate_response(resp : HTTP::Response)
      case response.status_code
      when 404 then raise ""
      end
    end
      
  end
end