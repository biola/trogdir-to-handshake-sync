class Handshake::Client
  extend Handshake::Config

  # This creates class methods for each of the http_methods.
  # Each class method takes an endpoint string and an options hash.
  # These class methods are responsible for dynamically creating
  # instance methods whos name is derived from options[:as]
  # This allows us to have a DSL for creating instance methods.
  # Examples:
  #   get "/users"
  #   post "/users", as: :create

  def self.define_http_class_methods(http_method)
    self.define_singleton_method(http_method) do |endpoint, options = {}|

      headers = authorization.merge(options[:headers] || {})
      url = base_url + endpoint
      instance_method_name = options[:as] || http_method

      define_method(instance_method_name) do |params = {}|
        if params[:id]
          url << "/#{params[:id]}"
          params.delete(:id)
        end

        params = { params: params }

        response = self.class.rest_client.execute(method: http_method,
                                                  url: url,
                                                  headers: headers.merge(params) )
        JSON.parse(response)
      end
    end
  end

  def self.rest_client
    RestClient::Request
  end

  http_methods = [:get, :post, :put, :delete]

  http_methods.each do |http_method|
    define_http_class_methods(http_method)
  end

  def base_url
    self.class.superclass.base_url
  end

end
