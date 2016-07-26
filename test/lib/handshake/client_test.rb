require 'test_helper'

module Handshake
  class ClientTest < ActiveSupport::TestCase

    class FakeSubclass < Client
      get '/foo'
      get '/bar', as: :bar
    end

    def setup
      @class = Handshake::Client
      @subclass = FakeSubclass
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

    test "subclass instances should have enpoint instance methods" do
      instance = @subclass.new
      assert_respond_to instance, :get
      assert_respond_to instance, :bar
    end

    test "subclass instances should execute call to external api" do
      fake_rest_client = mock('object')
      fake_rest_client.expects(:execute).returns("[]")
      instance = @subclass.new(fake_rest_client)
      instance.get
    end

  end
end
