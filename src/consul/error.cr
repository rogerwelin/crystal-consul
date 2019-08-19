require "http/client"

module Consul
  module Error
    class Error < Exception; end

    class ApiError < Error
      getter resp

      def initialize(@resp : HTTP::Client::Response)
        super(build_error_message)
      end

      private def build_error_message
        "Server responded with code #{resp.status_code}, message: " \
        "#{resp.body}"
      end
    end

    class BadRequest < ApiError; end

    class Unauthorized < ApiError; end

    class Forbidden < ApiError; end

    class RequestTimeout < ApiError; end

    class NotFound < ApiError; end

    class PayloadTooLarge < ApiError; end

    class InternalServerError < ApiError; end
  end
end
