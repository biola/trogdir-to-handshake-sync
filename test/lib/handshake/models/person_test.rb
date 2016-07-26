require 'test_helper'

module Handshake::Models
  class PersonTest < ActiveSupport::TestCase

    def described_class
      Person
    end

    def attrs
      [:user_type, :id, :username, :first_name, :last_name, :email_address, :mobile_number]
    end

    def setup
      @instance = described_class.new
    end

    test " should have the correct list of ATTRS" do
      assert_equal described_class::ATTRS, attrs
    end

    test "instances should have accessors for each attribute" do
      attrs.each do |attr|
        assert_respond_to @instance, attr
      end
    end

    test ".find_all should call client and return an array of Persons" do
      fake_client = mock('object')
      fake_client.expects(:get).returns({ "users" => { "foo" => "bar" } })
      described_class.client = fake_client
      persons = described_class.find_all
      assert_instance_of Array, persons
      assert_instance_of Person, persons.first
    end

    test ".find_all should return an empty array if users are empty " do
      fake_client = mock('object')
      fake_client.expects(:get).returns({ "users" => "" })
      described_class.client = fake_client
      persons = described_class.find_all
      assert_instance_of Array, persons
      assert_empty persons
    end

    test ".find should call client and return a Person" do
      fake_client = mock('object')
      fake_client.expects(:get).returns({ "users" => { "foo" => "bar" } })
      described_class.client = fake_client
      person = described_class.find(query: "blah")
      assert_instance_of Person, person
    end

    test ".find should return nil if client response is empty" do
      fake_client = mock('object')
      fake_client.expects(:get).returns({ "users" => "" })
      described_class.client = fake_client
      person = described_class.find(query: "blah")
      assert_equal person, nil
    end
  end
end
