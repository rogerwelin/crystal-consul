require "./src/*"

c = Consul.client("localhost", 8500)
puts c.endpoint
kv = c.kv.get_key("apa")
puts kv.value
