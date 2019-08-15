require "./spec_helper"

describe Consul do
  context ".Agent" do

    it "should create service" do
      c = Consul.client()
      service = Consul::Service.new(
        name: "test-service", 
        port: 9000, 
        tags: ["master"],
        address: "10.42.168.10",
        tag_override: true,
        meta: {"version" => "1.0"},
        check: {"HTTP" => "http://localhost:9900", "Interval" => "10s"}
        )
      c.agent.register_service(service)
    end

    it "should return service conf with expected type" do
      c = Consul.client()
      service_conf = c.agent.get_service_conf(name: "test-service")
      service_conf.should be_a Consul::Types::Agent::ServiceConf
    end

    it "should return service conf with expected values" do
      c = Consul.client()
      service_conf = c.agent.get_service_conf(name: "test-service")
      service_conf.service.should eq "test-service"
      service_conf.port.should eq 9000
      service_conf.tags.should eq ["master"]
      service_conf.address.should eq "10.42.168.10"
      service_conf.enable_tag_override.should eq true
      service_conf.meta["version"].should eq "1.0"
    end
  
    it "should return service healh with expected type" do
      c = Consul.client()
      service_health = c.agent.get_service_health(name: "test-service")
      service_health.should be_a Array(Consul::Types::Agent::ServiceHealth)
    end

    it "should return service healh with expected values" do
      c = Consul.client()
      service_health = c.agent.get_service_health(name: "test-service")
      service_health[0].aggregated_status.should eq "critical"
      service_health[0].service.service.should eq "test-service"
    end

  end
end
  