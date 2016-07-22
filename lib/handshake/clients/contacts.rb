module Handshake::Clients
  class Contacts < Handshake::Client

    get "/contacts"

    post "/contacts"

    delete "/contacts/destroy"

  end
end
