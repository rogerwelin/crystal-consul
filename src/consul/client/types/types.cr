require "json"

module Types
  class KV
    JSON.mapping(
      key: {type: String, key: "Key"},
      value: {type: String, key: "Value"},
    )
  end
end