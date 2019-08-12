require "./src/*"
require "base64"

# https://crystal-lang.org/api/0.30.0/JSON/Serializable.html

c1 = Consul.client(host: "localhost", port: 8500, token: "abc234")
puts c1.token
puts c1.port

c = Consul.client(host: "localhost", port: 8500)

puts "-------------------"
puts "::service::"
service1 = Consul::Service.new
service1.name = "service-example"
service1.tags = ["master"]
service1.address = "10.12.12.12"
service1.port = "8509"
puts service1.name
puts service1.tags
puts service1.port

puts "-------------------"

puts "-------------------"
puts c.kv.create_key("animal/apa", "gorilla")
kv = c.kv.get_key("animal/apa")
kv = c.kv.get_key("apa")

begin
  c.kv.get_key("should be bad request")
rescue ex : Consul::Error::BadRequest
  puts "Should be bad request: #{ex}"
end

begin
  c.kv.get_key("not-found")
rescue ex : Consul::Error::NotFound
  puts "Should be 404: #{ex}"
end

puts kv.value
c.kv.delete_key("animal/apa")
puts "-------------------"

puts "-------------------"
service = {"Service" => "kafka", "ID" => "redis1", "Tags": ["master"]}
c.catalog.register(
  node: "node.apa2",
  address: "127.0.0.1",
  service: service)

puts "-------------------"

puts "-------------------"
dc = c.catalog.list_datacenters
puts dc
puts typeof(dc)
puts "-------------------"

puts "-------------------"
services = c.catalog.list_services
puts services
puts "-------------------"

puts "-------------------"
nodes = c.catalog.list_nodes
# c.catalog.deregister("")
puts nodes
nodes.each do |node|
  puts "#{node.id} => #{node.node}"
end
puts "-------------------"

puts "-------------------"
nodes = c.catalog.list_nodes_for_service(service: "redis")
puts nodes
puts "-------------------"

puts "-------------------"
leader = c.status.get_leader
puts leader
puts "-------------------"

puts "-------------------"
peers = c.status.list_raft_peers
puts peers
puts typeof(peers)
puts "-------------------"

puts "-------------------"
# check = {"HTTP" => "http://localhost", "Args" => ["/usr/local/bin/check_redis.py"], "Interval" => "10s"}
check = {"HTTP" => "http://localhost", "Interval" => "10s"}
check2 = {"HTTP" => "http://localhost:8500", "Interval" => "10s"}
# check = {"HTTP" => "http://localhost", "Interval" => "10s", "TTL" => "15s"}
c.agent.register_service(name: "kallekula", port: 7777, tags: ["master"], check: check)
c.agent.register_service(name: "kallekula2", port: 7778, tags: ["stage"], check: check2)
c.agent.deregister_service(service_id: "kallekula")
c.agent.register_service(name: "kallekula", port: 7777, tags: ["master"], check: check)
puts "-------------------"

puts "-------------------"
s = c.agent.get_services
puts s
ss = c.agent.get_service_conf("kallekula2")
puts ss.service
puts ss.tags
h = c.agent.get_service_health("kallekula2")
puts h
c.agent.set_service_maintenenance(service_id: "kallekula2", enable: false, reason: "for the lulz")
puts "-------------------"

puts "-------------------"
puts "Events"
event = c.event.create_event(name: "custom-event", service: "kallekula2")
c.event.create_event(name: "test", service: "kallekula")
puts event.id
puts event.name
e = c.event.get_events
puts e

e.each do |ee|
  puts Base64.decode_string(ee.payload)
end
puts "-------------------"

puts "-------------------"
puts "Health"
h = c.health.get_checks_for_node("node.apa2")
# h = c.health.get_checks_for_node("6b98916d578f")
puts h
sh = c.health.get_checks_for_service("kallekula2")
puts sh
puts "-------------------"
