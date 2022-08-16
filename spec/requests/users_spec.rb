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

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path }

    it 'Successfully gets index' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders index template' do
      expect(response).to render_template('index')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Here is a list of all Users')
    end
  end

  describe 'GET #show' do
    subject(:author) { User.create(name: 'Bill', photo: 'none', bio: 'I\'m just a Bill. Yes, I\'m only a Bill.') }

    before(:example) do
      get "#{users_path}/#{author.id}"
    end

    after(:example) { User.destroy_all }

    it 'Successfully gets show' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders show template' do
      expect(response).to render_template('show')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Here is the specific User')
    end
  end
end
