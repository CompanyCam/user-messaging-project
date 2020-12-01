# frozen_string_literal: true

class User
  VALID_DELIVERY_METHODS = %w(sms email).freeze
  private_constant :VALID_DELIVERY_METHODS

  def initialize(**attrs)
    attrs.each do |key, value|
      send("#{key}=".to_sym, value) if respond_to?("#{key}=".to_sym)
    end
  end

  attr_accessor :first_name, :last_name, :phone_number, :email
  attr_accessor :delivery_methods
  attr_accessor :last_message_sent

  def delivery_methods=(values)
    @delivery_methods = Array(values).select { |item| VALID_DELIVERY_METHODS.include?(item) }
  end

  def delivery_methods
    @delivery_methods || []
  end

  def name
    [first_name, last_name].compact.join(' ')
  end

  def touch(attribute)
    return false unless respond_to?(attribute.to_sym)
    send("#{attribute}=", Time.now)
  end
end
