module Handshake::Clients
  class Users < Handshake::Client

    # This is a mini DSL to define endpoint methods.
    # The http methods are calls to class methods that
    # were dynamically defined in Handshake::Client.
    # These create instance methods with the same name
    # as the http method. If an "as:" option is defined,
    # the instance method will be named as such.
    # Example: 
    #   client = Handshake::Clients::Users.new
    #   client.get
    #   client.start_sync

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

