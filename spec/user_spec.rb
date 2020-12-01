# frozen_string_literal: true

require 'spec_helper'
require_relative '../user'

RSpec.describe User do
  context '#initialize' do
    it 'allows passing all of the attr values' do
      user = User.new(first_name: 'Test', last_name: 'User', email: 'test.user@companycam.com', delivery_methods: 'email')
      expect(user.first_name).to eq('Test')
      expect(user.last_name).to eq('User')
      expect(user.email).to eq('test.user@companycam.com')
    end
  end

  context '#delivery_methods=' do
    it 'coerces to an array' do
      user = User.new(delivery_methods: 'email')
      expect(user.delivery_methods).to eq(['email'])
    end
  end

  context '#delivery_methods' do
    it 'returns an email array if nil' do
      user = User.new(delivery_methods: nil)
      expect(user.delivery_methods).to eq([])
    end
  end

  context '#name' do
    context 'with first and last name' do
      it 'returns the full name' do
        user = User.new(first_name: 'Test', last_name: 'User')
        expect(user.name).to eq('Test User')
      end
    end

    context 'with only a first name' do
      it 'returns the first name' do
        user = User.new(first_name: 'Test')
        expect(user.name).to eq('Test')
      end
    end

    context 'with only a last name' do
      it 'returns the last name' do
        user = User.new(last_name: 'User')
        expect(user.name).to eq('User')
      end
    end
  end

  context '#touch' do
    it 'updates the timestamp' do
      user = User.new(last_message_sent: nil)
      user.touch(:last_message_sent)
      expect(user.last_message_sent).to_not be_nil
    end
  end
end
