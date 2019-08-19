require "json"

module Consul
  class Service
    property id, service, name, address, tags, port, tag_override, meta, check

    JSON.mapping(
      id: {type: String, key: "ID", nilable: true},
      service: {type: String, key: "Service", nilable: true},
      name: {type: String, key: "Name", nilable: true},
      address: {type: String, key: "Address", nilable: true},
      tags: {type: Array(String), key: "Tags", nilable: true},
      port: {type: Int32, key: "Port"},
      tag_override: {type: Bool, key: "EnableTagOverride"},
      meta: {type: Hash(String, String), key: "Meta", nilable: true},
      check: {type: Hash(String, String), key: "Check", nilable: true}
    )

    def initialize(
      @id : String? = nil,
      @name : String = "",
      @service : String = "",
      @address : String? = nil,
      @tags = [] of String,
      @port : Int32 = 0,
      @tag_override : Bool = false,
      @meta = {} of String => String,
      @check = {} of String => String
    )
    end
  end
end
