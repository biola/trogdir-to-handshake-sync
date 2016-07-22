module Handshake::Clients
  class Users < Handshake::Client

    get "/users"

    post "/users"

    post "/users/start_sync", as: :start_sync

    post "/users/create_or_update", as: :create_or_update

    post "/users/sync_details", as: :sync_details

    post "/users/end_sync", as: :end_sync

    put "/users/update"

    delete "/users/destroy"

  end
end

