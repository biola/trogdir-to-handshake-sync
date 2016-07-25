module Handshake::Models

  # All Handshake models inherit from this base class.
  # The idea is for the subclasses to set an ATTRS constant with
  # an array of attributes. Calling .define_accessors will
  # dynamically create setters and getters for them.

  class Base
    include Handshake::Exceptions

    class << self
      attr_accessor :client
    end

    attr_accessor :errors
    private :errors=

    # Class Methods

    def self.define_accessors(attributes)
      attributes.map(&:to_s).each do |name|
        create_setter(name)
        create_getter(name)
      end
    end

    def self.create_setter(name)
      create_instance_method("#{name}=".to_sym) do |val|
        instance_variable_set("@" + name, val)
      end
    end

    def self.create_getter(name)
      create_instance_method(name.to_sym) do
        instance_variable_get("@" + name)
      end
    end

    def self.create_instance_method(name, &block)
      self.send(:define_method, name, &block)
    end

    # Instance Methods

    def initialize(attributes = nil)
      if attributes
        attributes.each do |key, value|
          if self.respond_to? key.to_sym
            self.send("#{key}=".to_sym, value)
          end
        end
      end
    end

    def client
      self.class.client
    end
  end
end
