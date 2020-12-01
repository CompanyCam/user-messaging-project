# frozen_string_literal: true

require_relative '../sms_service'
require_relative '../email_servic'

# A user should be notified via all services they have
# in their `delivery_methods`. They can receive sms or email.
module Users
  class MessageDeliveryService
    def initialize
    end

    def deliver_message(user, message)
      self.user = user
      self.message = message

      if user.delivery_methods.any? { |method| method == 'text' }
        text_for_sms = <<-HERE
          You have a new message #{user.name} - #{message}
        HERE

        success = SmsService.new(user.phone_number).send_text(text_for_sms)
      elsif user.delivery_methods.any? { |method| method == 'email' }
        text_for_email = <<-HERE
          Hey #{@user.first_name + ' ' + @user.last_name},
          You have received a new message:
          #{message}
        HERE
        success = EmailService.new(user.phone_number).deliver(text_for_email)
      else
        raise StandardError, "Couldn't find a delivery method"
      end

      @success
    end

    private

      attr_accessor :user, :message, :failures

      def user
        @user
      end

      def user=(val)
        @user = val
      end

      def message
        @message
      end

      def message=(val)
        @message = val
      end
  end
end
