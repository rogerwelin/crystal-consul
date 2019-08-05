require "json"

module Types
  class KV
    JSON.mapping(
      key: {type: String, name: "Key"},
      value: {type: String, name: "Value"},
    )
  end
end