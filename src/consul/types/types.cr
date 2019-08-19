require "json"

module Consul
  module Types

    module KV
      class KV
        JSON.mapping(
          key:    {type: String, key: "Key"},
          value:  {type: String, key: "Value"},
        )
      end
      struct KvPair
        getter key, value

        def initialize(@key : String, @value : String)
        end
      end
    end

    module Catalog
      class Node
        JSON.mapping(
          id:               {type: String, key: "ID"},
          node:             {type: String, key: "Node"},
          address:          {type: String, key: "Address"},
          datacenter:       {type: String, key: "Datacenter"},
          tagged_addresses: {type: Hash(String, String), key: "TaggedAddresses", nilable: true},
          meta:             {type: Hash(String, String), key: "Meta", nilable: true}
        )
      end

      class NodeService
        JSON.mapping(
          id:               {type: String, key: "ID"},
          node:             {type: String, key: "Node"},
          address:          {type: String, key: "Address"},
          datacenter:       {type: String, key: "Datacenter"},
          tagged_addresses: {type: Hash(String, String), key: "TaggedAddresses", nilable: true},
          node_meta:        {type: Hash(String, String), key: "NodeMeta", nilable: true},
          service_id:       {type: String, key: "ServiceID"},
          service_name:     {type: String, key: "ServiceName"},
          service_tags:     {type: Array(String), key: "ServiceTags", nilable: true},
          service_address:  {type: String, key: "ServiceAddress"},
          service_meta:     {type: Hash(String, String), key: "ServiceMeta"},
          service_port:     {type: Int32, key: "ServicePort"},
        )
      end
    end

    module Agent
      class ServiceConf
        JSON.mapping(
          kind:                 {type: String, key: "Kind", nilable: true},
          id:                   {type: String, key: "ID"},
          service:              {type: String, key: "Service"},
          tags:                 {type: Array(String), key: "Tags", nilable: true},
          meta:                 {type: Hash(String, String), key: "Meta"},
          address:              {type: String, key: "Address"},
          port:                 {type: Int32, key: "Port"},
          enable_tag_override:  {type: Bool, key: "EnableTagOverride"},
          content_hash:         {type: String, key: "ContentHash"}
        )
      end

      class Service
        JSON.mapping(
          id:       {type: String, key: "ID"},
          service:  {type: String, key: "Service"},
          tags:     {type: Array(String), key: "Tags"},
          port:     {type: Int32, key: "Port"},
          address:  {type: String, key: "Address"}
        )
      end

      class Check 
        JSON.mapping(
          node:     {type: String, key: "Node"},
          check_id: {type: String, key: "CheckID"},
          name:     {type: String, key: "Name"},
          status:   {type: String, key: "Status"},
          output:   {type: String, key: "Output"}
        )
      end

      class ServiceHealth
        JSON.mapping(
          aggregated_status:  {type: String, key: "AggregatedStatus"},
          service:            {type: Service, key: "Service"},
          checks:             {type: Array(Check), key: "Checks"}
        )
      end
    end

    module Event
      class Event
        JSON.mapping(
          id:             {type: String, key: "ID"},
          name:           {type: String, key: "Name"},
          payload:        {type: String, key: "Payload"},
          node_filter:    {type: String, key: "NodeFilter"},
          service_filter: {type: String, key: "ServiceFilter"},
          vesion:         {type: Int32, key: "Version"},
          ltime:          {type: Int32, key: "LTime"}
        )
      end
    end

    module Health
      class Check
        JSON.mapping(
          node:           {type: String, key: "Node"},
          check_id:       {type: String, key: "CheckID"},
          name:           {type: String, key: "Name"},
          status:         {type: String, key: "Status"},
          notes:          {type: String, key: "Notes"},
          output:         {type: String, key: "Output"},
          service_id:     {type: String, key: "ServiceID"},
          service_name:   {type: String, key: "ServiceName"},
          service_tags:   {type: Array(String), key: "ServiceTags"}
        )
      end
    end

    module Coordinate
      class Wan
        JSON.mapping(
          datacenter:   {type: String, key: "Datacenter"},
          area_id:      {type: String, key: "AreaID"},
          coordinates:  {type: Array(Coordinates), key: "Coordinates"}
        )
      end
      class Lan
        JSON.mapping(
          node:     {type: String, key: "Node"},
          segment:  {type: String, key: "Segment"},
          coord:    {type: Coord, key: "Coord"}
        )
      end
      class Coord
        JSON.mapping(
          adjustment: {type: Int32, key: "Adjustment"},
          error:      {type: Float64, key: "Error"},
          height:     {type: Float64, key: "Height"},
          vec:        {type: Array(Int32), key: "Vec"}
        )
      end
      class Coordinates
        JSON.mapping(
          node:    {type: String, key: "Node"},
          segment: {type: String, key: "Segment", nilable: true},
          coord:   {type: Coord, key: "Coord"}
        )

      end
    end

  end
end