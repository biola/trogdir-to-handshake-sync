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

  http_methods.each do |http_method|
    self.define_singleton_method(http_method) do |endpoint, options = {}|
      instance_method_name = options[:as] || http_method
      headers = authorization.merge(options[:headers] || {})

      define_method(instance_method_name) do |params = nil|
        params = { params: params }
        id = params[:id]
        url = base_url + endpoint

        if id
          url << "/#{id}"
          params.delete(:id)
        end

        response = RestClient::Request.execute(method: http_method,
                                               url: url,
                                               headers: headers.merge(params) )
        JSON.parse(response)
      end
    end
  end

  def base_url
    self.class.superclass.base_url
  end

end
