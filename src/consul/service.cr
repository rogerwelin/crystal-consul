module Consul
  class Service

    property id, name, tags, port, address, tag_override, meta, check

    def initialize(
      @id           : String = "",
      @name         : String = "",
      @tags         = [] of String,
      @port         : String = "",
      @address      : String = "",
      @tag_override : Bool = false,
      @meta         = {} of String => String,
      @check        = {} of String => String
      )
    end

  end
end