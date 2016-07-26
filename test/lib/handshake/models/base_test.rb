require 'test_helper'

module Handshake::Models
  class BaseTest < ActiveSupport::TestCase

    def setup
      @class = Handshake::Models::Base
      @instance = @class.new
    end

    test "should respond to .client" do
      assert_respond_to @class, :client
    end

    test "should respond for .client=" do
      assert_respond_to @class, :client=
    end

    test ".define_accessors should create setters and getters on an instance" do
      attrs = [:first, :second]
      @class.define_accessors(attrs)

      assert_respond_to @instance, :first
      assert_respond_to @instance, :first=
      assert_respond_to @instance, :second
      assert_respond_to @instance, :second=
    end

    test "instances should respond to #client" do
      assert_respond_to @instance, :client
    end

    test "instances should respond to #errors" do
      assert_respond_to @instance, :errors
    end

    test "#errors= should be private among instances" do
      @instance.send :errors=, "blah"

      refute_respond_to @instance, :errors=
      assert_equal @instance.errors, "blah"
    end

  end
end
