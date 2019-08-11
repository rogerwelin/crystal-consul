module Consul
  class Service

    property id, name, tags, port, address, tag_override, meta, check

    def initialize(
      @id : String = "",
      @name : String = "",
      @tags : [] as Array(String),
      @port : String = "",
      @address : String = "",
      @tag_override : Bool = false,
      @meta : {} as Hash(String, String),
      @check : {} as Hash(String, String)
      )
    end

  end
end