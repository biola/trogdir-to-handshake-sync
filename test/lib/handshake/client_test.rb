require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def setup
    @class = Handshake::Client
  end

  test "should respond to .get, .post, .put, .delete" do
    assert_respond_to @class, :get
    assert_respond_to @class, :post
    assert_respond_to @class, :put
    assert_respond_to @class, :delete
  end

  test "instances should respond to #base_url" do
    instance = @class.new
    assert_respond_to instance, :base_url
  end

end
