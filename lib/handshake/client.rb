require 'handshake/config'
require 'rest-client'
require 'json'

class Handshake::Client
  extend Handshake::Config

  http_methods = [:get, :post, :put, :delete]

  # This creates class methods for each of the http_methods.
  # Each class method takes an endpoint string and an options hash.
  # These class methods are responsible for dynamically creating
  # instance methods whos name is derived from options[:as]
  # This allows us to have a DSL for creating instance methods like the following:
  #      get "/users", as: :find
  #      post "/users", as: :create

  http_methods.each do |method|
    self.define_singleton_method(method) do |endpoint, options = {}|
      method_name = options.fetch(:as)
      headers = authorization.merge(options[:headers] || {})

      define_method(options.fetch(:as)) do |params = nil|
        params = { :params => params }

        response = RestClient::Request.execute(method: method,
                                               url: base_url + endpoint,
                                               headers: headers.merge(params) )
        JSON.parse(response)
      end
    end
  end

  def base_url
    self.class.superclass.base_url
  end

end
