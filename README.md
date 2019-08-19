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
c.kv.create_key("stage/service-example/version", "1")
c.kv.create_key("stage/service-example/tag", "master")

# read key
c.kv.get_key("stage/service-example/version")
# Consul::Types::KV::KvPair(@key="stage/service-example/version", @value="1")

# you can also get keys recursively
c.kv.get_key("stage", recurse: true)
# [Consul::Types::KV::KvPair(@key="stage/service-example/tag", @value="master"), Consul::Types::KV::KvPair(@key="stage/service-example/version", @value="1")]

# register a service on the local agent
service = Consul::Service.new()
service.service = "service-example"
service.tags = ["master"]
service.port = 9922

c.agent.register_service(service)
```

For more examples and usage view [the example page](https://github.com/rogerwelin/crystal-consul/blob/master/examples/examples.md)


## Project Status

Implemented endpoints implements all consistency modes, filter options and query parameters as specified by Consul HTTP API doc.

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


## Testing

Only a working Crystal installation and Docker is required. Project does not use mocks, instead all endpoints are tested against a running Consul docker container.

1. Run ```docker run -d -p 8500:8500 consul:1.5.1```
2. Run ```crystal spec``` from the project root

## Contributing

Pull requests are very much appreciated! When you create a PR please ensure:

* All current tests pass  
* To run ```crystal tool format``` on added code  
* To add tests for your new features, if applicable  
* To add doc comments for new api features you add  


1. Fork it (<https://github.com/rogerwelin/crystal-consul/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Roger Welin](https://github.com/rogerwelin) - creator and maintainer
