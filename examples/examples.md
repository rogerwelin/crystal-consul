
### Creating a client

```crystal
# create a default client
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
c.kv.get_key("animal", recurse: true)

# get kv keys recursively
c.kv.get_key("animal", recurse: true, keys: true)

# delete a kv pair
c.kv.delete_key("animal/ape")

# catch exception
begin
  c.kv.get_key("animal/ape")
rescue ex : Consul::Error::NotFound
  puts "got: #{ex}"
rescue ex : Exception
  raise "this was unexpected: #{ex}"
end
```

### Agent

```crystal
# register a service on the local agent
service = Consul::Service.new()
service.name = "service-example"
service.tags = ["master"]
service.address = "10.42.10.11"
service.port = 9922
service.check = {"HTTP" => "http://localhost:9922", "Interval" => "10s}

c.agent.register_service(service)

# get services that are registered on the local agent
c.agent.get_services()
{"service-example" => #<Consul::Types::Agent::Service:0x7fd03885f980 @id="service-example", @service="service-example", @tags=["master"], @port=9922, @address="10.42.10.11">

# get service configuration for a specified service by name
c.agent.get_service_conf("service-example")
# <Consul::Types::Agent::ServiceConf:0x7f167f191a50 @kind=nil, @id="service-example", @service="service-example", @tags=["master"], @meta={}, @address="10.42.10.11", @port=9922, @enable_tag_override=false, @content_hash="631ec0c28596219c">

# deregister a service by service id
c.agent.deregister_service("service-example")

# register a check on the local agent
check = Consul::Check.new()
check.name = "check kibana"
check.http = "http://localhost:9200"
check.interval = "10s"

c.agent.register_check(check)

# get all checks registred on the local agent
c.agent.get_checks()
{"check kibana" => #<Consul::Types::Agent::Check:0x7f4ebcdb7000 @node="vagrant", @check_id="check kibana", @name="check kibana", @status="critical", @output="">, "service:service-example" => #<Consul::Types::Agent::Check:0x7f4ebcdbef00 @node="vagrant", @check_id="service:service-example", @name="Service 'service-example' check", @status="critical", @output="Get www.google.com: unsupported protocol scheme \"\"">}

# get checks and query with filter
c.agent.get_checks(filter: "Name == \"check kibana\"")
{"check kibana" => #<Consul::Types::Agent::Check:0x7fb3a7f9d700 @node="vagrant", @check_id="check kibana", @name="check kibana", @status="critical", @output="Get http://localhost:9200: dial tcp [::1]:9200: connect: connection refused">}
```


### Catalog

```crystal
# get datacenters
c.catalog.get_datacenters()
# Array(String) eg ["dc1"]

# get nodes
c.catalog.get_nodes()
```
