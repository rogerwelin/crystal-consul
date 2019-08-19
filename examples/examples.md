
### Creating a client

```crystal
c = Consul.client()

# create a client by specifying host and port
c = Consul.client(host: "127.0.0.1", port: 8500)

# create a client by setting all parameters
c = Consul.client(host: "127.0.0.1", port: 8500, scheme: "https", token: "my-secret-consul-token", consistency: "default")
```

### KV Store

```crystal
# create a kv
c.kv.create_key("animal/ape", "gorilla")

# get a kv value
c.kv.get_key("animal/ape")

# get kv recursively
c.kv.get_key("animal/ape", recurse: true)

# delete a kv pair
c.kv.delete_key("animal/ape")

# catch exception
begin
  c.kv.get_key("animal/ape")
rescue ex : Consul::Error::NotFound
  puts "got: #{ex}"
end
```

### Catalog

```crystal
# get datacenters
c.catalog.get_datacenters()
# Array(String) eg ["dc1"]

# get nodes
c.catalog.get_nodes()
```
