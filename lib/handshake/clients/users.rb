require "handshake/client"

module Handshake::Clients
  class Users < Handshake::Client

    get "/users", as: :find

    post "/users", as: :create

    put "/users/update", as: :update

    delete "/users/destroy", as: :delete

  end
end

