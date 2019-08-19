require "./spec_helper"

describe Consul do
  context ".Agent" do
    it "should create service" do
      c = Consul.client
      service = Consul::Service.new(
        name: "test-service",
        port: 9000,
        tags: ["master"],
        address: "10.42.168.10",
        tag_override: true,
        meta: {"version" => "1.0"},
        check: {"HTTP" => "http://localhost:9900", "Interval" => "10s"}
      )
      service2 = Consul::Service.new(
        name: "service-proxy",
        port: 9999,
        tags: ["stage"],
        address: "10.42.168.11",
        tag_override: true,
        meta: {"version" => "1.0"},
        check: {"HTTP" => "http://localhost:9999", "Interval" => "10s"}
      )
      c.agent.register_service(service)
      c.agent.register_service(service2)
    end

    it "should return service conf with expected type" do
      c = Consul.client
      service_conf = c.agent.get_service_conf(name: "test-service")
      service_conf.should be_a Consul::Types::Agent::ServiceConf
    end

    it "should return service conf with expected values" do
      c = Consul.client
      service_conf = c.agent.get_service_conf(name: "test-service")
      service_conf.service.should eq "test-service"
      service_conf.port.should eq 9000
      service_conf.tags.should eq ["master"]
      service_conf.address.should eq "10.42.168.10"
      service_conf.enable_tag_override.should eq true
      service_conf.meta["version"].should eq "1.0"
    end

    it "should return services with expected type" do
      c = Consul.client
      c.agent.get_services.should be_a Hash(String, Consul::Types::Agent::Service)
    end

    it "should return services with with working filter" do
      c = Consul.client
      service = c.agent.get_services(filter: "Service == \"service-proxy\"")
      service.size.should eq 1
    end

    it "should return service healh with expected type" do
      c = Consul.client
      service_health = c.agent.get_service_health(name: "test-service")
      service_health.should be_a Array(Consul::Types::Agent::ServiceHealth)
    end

    it "should return service healh with expected values" do
      c = Consul.client
      service_health = c.agent.get_service_health(name: "test-service")
      service_health[0].aggregated_status.should eq "critical"
      service_health[0].service.service.should eq "test-service"
    end

    it "should create check" do
      c = Consul.client
      check = Consul::Check.new(
        name: "test-check",
        interval: "30s",
        http: "https://www.google.com",
        timeout: "5s",
        notes: "for tests"
      )
      c.agent.register_check(check)
    end

    it "should return checks with expected type" do
      c = Consul.client
      c.agent.get_checks.should be_a Hash(String, Consul::Types::Agent::Check)
    end

    it "should return check with expected values" do
      c = Consul.client
      check = c.agent.get_checks
      check["test-check"].name.should eq "test-check"
    end

    it "should deregister a check" do
      c = Consul.client
      checks = c.agent.get_checks
      check_id = checks["test-check"].check_id

      c.agent.deregister_check(check_id)
      begin
        ch = c.agent.get_checks
        ch["test-check"]
      rescue ex : Exception
        ex.should be_a KeyError
      end
    end
  end
end
