# 💎 crystal-consul

[![Language](https://img.shields.io/badge/language-crystal-776791.svg)](https://github.com/crystal-lang/crystal)
[![Build Status](https://travis-ci.org/rogerwelin/crystal-consul.svg?branch=master)](https://travis-ci.org/rogerwelin/crystal-consul)

Crystal client for Consul HTTP API. For more information about the Consul HTTP API, go [here](https://www.consul.io/api/index.html).
Crystal-consul does not use any depenencies outside stdlib, hence no transitive dependencies when you include it in your project. 

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crystal-consul:
       github: rogerwelin/crystal-consul
   ```

2. Run `shards install`

## Example Usage

```crystal
require "consul"

# create a default client
c = Consul.client()

# create a key
c.kv.create_key("stage/my_app", "version: 1")

# read key
c.kv.get_key("stage/my_app")
# Consul::Types::KV::KvPair(@key="stage/myapp", @value="version: 1")

# you can also get keys recursively
c.kv.get_key("stage", recurse: true)
# [Consul::Types::KV::KvPair(@key="stage/myapp", @value="version: 1")]

# register a service on the local agent
service = Consul::Service.new()
service.service = "service-example"
service.tags = ["master"]
service.port = 9922

c.agent.register_service(service)


```


## Project Status

#### Completed  
* Agent
* Catalog
* Coordinates
* Events
* Health
* KV Store
* Snapshots
* Status

#### TO-DO  
* ACLs
* Config
* Connect
* Operator
* Prepared Queries
* Sessions
* Transactions


## Contributing

1. Fork it (<https://github.com/rogerwelin/crystal-consul/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Roger Welin](https://github.com/rogerwelin) - creator and maintainer
