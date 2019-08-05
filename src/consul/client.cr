require "./client/**"
require "json"
require "http/client"

module Consul
  class Client
    include Kv
  end
end
