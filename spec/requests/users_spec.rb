require 'rails_helper'

RSpec.describe 'The Blog App', type: :request do
  subject(:author) do
    user = User.new(name: 'Roberto', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    bio: 'Teacher from Mexico.', email: 'roberto@mail.com')
    user.password = 'valido'
    user.password_confirmation = 'valido'
    user.confirm
    user
  end

  before(:each) do
    sign_in(author)
  end

  after(:each) do
    sign_out(author)
  end

  describe 'correctly handles the route users#index' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'users', action: 'index' }, users_path)
    end

    it '( generates )' do
      assert_generates root_path, { controller: 'users', action: 'index' }
    end
  end

  describe 'correctly handles the route users#show' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'users', action: 'show', id: '1' }, user_path(1))
    end

    it '( generates )' do
      assert_generates user_path(1), { controller: 'users', action: 'show', id: '1' }
    end
  end
end

RSpec.describe 'Users', type: :request do
  subject(:author) do
    user = User.new(name: 'Roberto', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    bio: 'Teacher from Mexico.', email: 'roberto@mail.com')
    user.password = 'valido'
    user.password_confirmation = 'valido'
    user.confirm
    user
  end

  before(:each) do
    sign_in(author)
  end

  after(:each) do
    sign_out(author)
  end

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
    before(:example) { get user_path(author.id) }

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
