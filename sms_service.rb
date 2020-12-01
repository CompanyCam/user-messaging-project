# frozen_string_literal: true

require_relative './delivery_error'

# DONT modify this file as part of your test
# it's meant to act as a stub
class SmsService
  def initialize(phone_number)
    @phone_number = phone_number
  end

  def deliver(message)
    raise DeliveryError unless phone_number =~ VALID_PHONE_NUMBER_REGEX
    puts "====Delivering====\n#{message}\nTO: #{phone_number}"
  end

  private
    VALID_PHONE_NUMBER_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
    private_constant :VALID_PHONE_NUMBER_REGEX

    attr_reader :phone_number
end
