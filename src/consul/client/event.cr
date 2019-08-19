require "../types/*"
require "../transport"

module Consul
  class Event < Consul::Transport
    # create_event triggers a new user event
    def create_event(
      name : String,
      datacenter : String? = nil,
      node : String? = nil,
      service : String? = nil,
      tag : String? = nil
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

      resp = put("/v1/event/fire/#{name}", data: data.to_json)
      return Consul::Types::Event::Event.from_json(resp.body)
    end

    # get_events returns the most recent events (up to 256) known by the agent
    def get_events(
      name : String? = nil,
      node : String? = nil,
      service : String? = nil,
      tag : String? = nil
    ) : Array(Consul::Types::Event::Event)
      endpoint = "/v1/event/list"

      unless name.nil?
        endpoint = "#{endpoint}?name=#{name}"

        unless node.nil?
          endpoint = "#{endpoint}&node=#{node}"
        end

        unless service.nil?
          endpoint = "#{endpoint}&service=#{service}"
        end

        unless tag.nil?
          endpoint = "#{endpoint}&tag=#{tag}"
        end
      end

      resp = get(endpoint)
      return Array(Consul::Types::Event::Event).from_json(resp.body)
    end
  end
end
