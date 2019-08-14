require "./spec_helper"

describe Consul do
  context "event" do
   
    it "should create event & return expected type" do
      c = Consul.client()
      c.event.create_event(name: "test_event").should be_a Consul::Types::Event::Event
    end

    it "should return events with expected type" do
      c = Consul.client()
      c.event.get_events().should be_a Array(Consul::Types::Event::Event)
    end
   
  end
end
  