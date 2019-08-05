require "./src/*"

c  = Consul.client("localhost", 8500)
puts c.endpoint
puts c.apa
puts c.kv.get_key()
