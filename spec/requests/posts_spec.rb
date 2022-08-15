require 'rails_helper'

RSpec.describe 'The Blog App', type: :request do
  describe 'correctly handles the route posts#index' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'posts', action: 'index', user_id: '1' }, '/users/1/posts')
    end

    it '( generates )' do
      assert_generates '/users/1/posts', { controller: 'posts', action: 'index', user_id: '1' }
    end
  end

  describe 'correctly handles the route posts#show' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'posts', action: 'show', user_id: '1', id: '1' }, '/users/1/posts/1')
    end

    it '( generates )' do
      assert_generates '/users/1/posts/1', { controller: 'posts', action: 'show', user_id: '1', id: '1' }
    end
  end
end
