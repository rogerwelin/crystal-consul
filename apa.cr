require "./src/*"

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

dc = c.catalog.list_datacenters
puts dc

services = c.catalog.list_services
puts services

leader = c.status.get_leader
puts leader

peers = c.status.list_raft_peers
puts peers
