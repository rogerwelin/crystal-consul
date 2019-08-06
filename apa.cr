require "./src/*"

c = Consul.client("localhost", 8500)
puts c.endpoint
c.kv.create_key("animal/apa", "gorilla")
kv = c.kv.get_key("animal/apa")
puts kv.value
c.kv.delete_key("animal/apa")
