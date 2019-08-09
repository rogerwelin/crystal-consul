require "../types/*"

module Consul
  class Event

    getter client

    def initialize(@client : HTTP::Client)
    end

    # create_event triggers a new user event
    def create_event(
      name        : String, 
      datacenter  : String? = nil,
      node        : String? = nil,
      service     : String? = nil,
      tag         : String? = nil
      ) : Consul::Types::Event::Event

      data = {} of String => String

      unless datacenter.nil?
        data["dc"] = datacenter
      end

      unless node.nil?
        data["node"] = node
      end

      unless service.nil?
        data["service"] = service
      end

      unless tag.nil?
          data["tag"] = tag
      end

      resp = Consul::Util.put(client, "/v1/event/fire/#{name}", data: data.to_json)
      return Consul::Types::Event::Event.from_json(resp.body)
    end

    # get_events returns the most recent events (up to 256) known by the agent
    def get_events(
      name        : String? = nil, 
      node        : String? = nil,
      service     : String? = nil,
      tag         : String? = nil
      ) : Array(Consul::Types::Event::Event)

      url = "/v1/event/list"

      unless name.nil?
        url = "#{url}?name=#{name}"

        unless node.nil?
          url = "#{url}&node=#{node}"
        end

        unless service.nil?
          url = "#{url}&service=#{service}"
        end

        unless tag.nil?
          url = "#{url}&tag=#{tag}"
        end
      end

      resp = Consul::Util.get(client, "#{url}")
      return Array(Consul::Types::Event::Event).from_json(resp.body)
    end
  
    end
  end