class Handshake::Models::Base
  include Handshake::Exceptions

  class << self
    attr_accessor :client
  end

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

  def initialize(attributes = nil)
    if attributes
      attributes.each do |key, value|
        if self.respond_to? key.to_sym
          self.send("#{key}=".to_sym, value)
        end
      end
    end
  end

  # Note: this is an instance method
  def client
    self.class.client
  end
end
