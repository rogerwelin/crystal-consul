require "./src/*"

# https://crystal-lang.org/api/0.30.0/JSON/Serializable.html

c = Consul.client(endpoint: "localhost", port: 8500)
puts c.endpoint
c.kv.create_key("animal/apa", "gorilla")
kv = c.kv.get_key("animal/apa")
puts kv.value
c.kv.delete_key("animal/apa")

service = {"Service" => "redis", "ID" => "redis1", "Tags": ["master"]}
c.catalog.register(
  node: "node.apa",
  address: "123.132.13",
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
