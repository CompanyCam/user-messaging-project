# frozen_string_literal: true

require 'spec_helper'
require_relative '../../users/message_delivery_service'

RSpec.describe Users::MessageDeliveryService do
  let(:message) { 'This is a message' }

  context '#initialize' do
    let(:user) do
      User.new(
        first_name: 'Test',
        last_name: 'User'
      )
    end

    it 'accepts a user and a message' do
      service = described_class.new(user, message)
      expect(service.user).to eq(user)
      expect(service.message).to eq(message)
    end

    it 'initializes an failures list' do
      service = described_class.new(user, message)
      expect(service.failures).to eq([])
    end
  end

  context '#deliver_message' do

    context 'when the user has no delivery methods' do
      let(:user) do
        User.new(
          first_name: 'Test',
          last_name: 'User'
        )
      end

      it 'does not call a service' do
        expect_any_instance_of(SmsService).to_not receive(:deliver)
        expect_any_instance_of(EmailService).to_not receive(:deliver)
        described_class.new(user, message).deliver_message
      end
    end

    context 'when the user has only sms delivery method' do
      let(:user) do
        User.new(
          first_name: 'Test',
          last_name: 'User',
          phone_number: '+14025551212',
          delivery_methods: 'sms'
        )
      end

      it 'does not call a service' do
        expect_any_instance_of(SmsService).to receive(:deliver)
        expect_any_instance_of(EmailService).to_not receive(:deliver)
        described_class.new(user, message).deliver_message
      end
    end

    context 'when the user has only email delivery method' do
      let(:user) do
        User.new(
          first_name: 'Test',
          last_name: 'User',
          email: 'test.user@companycam.com',
          delivery_methods: 'email'
        )
      end

      it 'does not call a service' do
        expect_any_instance_of(SmsService).to_not receive(:deliver)
        expect_any_instance_of(EmailService).to receive(:deliver)
        described_class.new(user, message).deliver_message
      end
    end

    context 'when the user has email and sms delivery methods' do
      let(:user) do
        User.new(
          first_name: 'Test',
          last_name: 'User',
          email: 'test.user@companycam.com',
          phone_number: '+14025551212',
          delivery_methods: ['email', 'sms']
        )
      end

      it 'does not call a service' do
        expect_any_instance_of(SmsService).to receive(:deliver)
        expect_any_instance_of(EmailService).to receive(:deliver)
        described_class.new(user, message).deliver_message
      end
    end

    context 'last_message_sent' do
      let(:user) do
        User.new(
          first_name: 'Test',
          last_name: 'User',
          email: 'test.user@companycam.com',
          delivery_methods: 'email'
        )
      end

      it 'touches last_message_sent if at least one message is sent' do
        expect {
          described_class.new(user, message).deliver_message
        }.to change { user.last_message_sent }
      end
    end
  end
end
