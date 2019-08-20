require "./spec_helper"

describe Consul do
  context ".Health" do
    it "should return nodes for a given service with expected type" do
      c = Consul.client

      service1 = Consul::Service.new(
        name: "service1",
        port: 9000,
        tags: ["master"],
        address: "10.42.168.10",
        check: {"HTTP" => "http://localhost:9900", "Interval" => "1s"}
      )
      service2 = Consul::Service.new(
        name: "service2",
        port: 9900,
        tags: ["master"],
        address: "10.42.168.11",
        check: {"HTTP" => "http://localhost:8500", "Interval" => "1s"}
      )
      c.agent.register_service(service1)
      c.agent.register_service(service2)

      sleep(1)
      c.health.get_nodes_for_service("service2").should be_a Array(Consul::Types::Health::NodeService)
    end

    it "should return nodes with given filter" do
      c = Consul.client
      node = c.health.get_nodes_for_service(service: "service2", filter: "'Checks.Status == passing'")
      node.size.should eq 1
    end
  end
end
