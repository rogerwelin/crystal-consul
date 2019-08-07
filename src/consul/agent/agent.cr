module Consul
  class Agent

    def initialize(@port : Int32, @endpoint =  "")
        @endpoint = "http://localhost:#{port}/v1/agent"
    end

    def list_members()
    end


  end
end
