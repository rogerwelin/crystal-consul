require "./src/*"

apa  = Consul.client("localhost", 8500)
puts apa.endpoint
puts apa.apa
puts apa.get_key
