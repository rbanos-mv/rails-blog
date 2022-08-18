require 'rails_helper'

RSpec.describe 'The Blog App', type: :request do
  describe 'correctly handles the route posts#index' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'posts', action: 'index', user_id: '1' }, user_posts_path(1))
    end

    it '( generates )' do
      assert_generates user_posts_path(1), { controller: 'posts', action: 'index', user_id: '1' }
    end
  end

  describe 'correctly handles the route posts#show' do
    it '( recognizes )' do
      assert_recognizes({ controller: 'posts', action: 'show', user_id: '1', id: '1' }, user_post_path(1, 1))
    end

    it '( generates )' do
      assert_generates user_post_path(1, 1), { controller: 'posts', action: 'show', user_id: '1', id: '1' }
    end
  end
end

RSpec.describe 'Posts', type: :request do
  let(:author) { User.create(name: 'Tom', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', bio: 'Teacher from Mexico.') }
  subject(:post) { Post.create(author:, title: 'Hello 1', text: 'This is my first post') }

  after(:example) do
    Post.destroy_all
    User.destroy_all
  end

  describe 'GET #index' do
    before(:example) { get user_posts_path(author.id) }

    it 'Successfully gets index' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders index template' do
      expect(response).to render_template('index')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Here is a list of all Posts by User')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_post_path(author.id, post.id) }

    it 'Successfully gets show' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders show template' do
      expect(response).to render_template('show')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('Here is the specific Post')
    end
  end
end
