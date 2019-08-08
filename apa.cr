require "./src/*"

# https://crystal-lang.org/api/0.30.0/JSON/Serializable.html

c = Consul.client(endpoint: "localhost", port: 8500)
puts c.endpoint
c.kv.create_key("animal/apa", "gorilla")
kv = c.kv.get_key("animal/apa")

# c.kv.get_key("should be bad request")
# c.kv.get_key("not-found")

puts kv.value
c.kv.delete_key("animal/apa")

service = {"Service" => "kafka", "ID" => "redis1", "Tags": ["master"]}
c.catalog.register(
  node: "node.apa2",
  address: "127.0.0.1",
  service: service)

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
# check = {"HTTP" => "http://localhost", "Interval" => "10s", "TTL" => "15s"}
c.agent.register_service(name: "kallekula", port: 7777, tags: ["master"], check: check)
puts "-------------------"

puts "-------------------"
s = c.agent.get_services
puts s
ss = c.agent.get_service_conf("kallekula")
puts ss.service
puts ss.tags
puts "-------------------"
