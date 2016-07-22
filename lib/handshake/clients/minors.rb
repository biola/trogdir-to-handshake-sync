module Handshake::Clients
  class Minors < Handshake::Client

    get "/minors"

    post "/minors"

    delete "/minors/destroy"

  end
end
