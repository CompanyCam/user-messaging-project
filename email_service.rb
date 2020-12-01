# frozen_string_literal: true

require 'uri'
require_relative './delivery_error'

# DONT modify this file as part of your test
# it's meant to act as a stub
class EmailService
  def initialize(email)
    @email = email
  end

  def deliver(message)
    raise DeliveryError unless email =~ URI::MailTo::EMAIL_REGEXP
    puts "====Delivering====\n#{message}\nTO: #{email}"
  end

  private

    attr_reader :email
end
