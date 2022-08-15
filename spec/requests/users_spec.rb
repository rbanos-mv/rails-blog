require 'rails_helper'

RSpec.describe 'The Blog App', type: :request do
  describe 'correctly handles the route users#index' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'users', action: 'index' }, '/users')
    end

    it '( generates )' do
      assert_generates '/users', { controller: 'users', action: 'index' }
    end
  end

  describe 'correctly handles the route users#show' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'users', action: 'show', id: '1' }, '/users/1')
    end

    it '( generates )' do
      assert_generates '/users/1', { controller: 'users', action: 'show', id: '1' }
    end
  end
end
