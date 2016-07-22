module Handshake::Exceptions

  class ApiError < StandardError
    def initialize(msg = "Error on Handshake API")
      super
    end
  end

end
