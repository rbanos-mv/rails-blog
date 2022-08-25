require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:author) do
    user = User.new(name: 'Roberto', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    bio: 'Teacher from Mexico.', email: 'roberto@mail.com')
    user.password = 'valido'
    user.password_confirmation = 'valido'
    user.confirm
    user
  end
  subject(:post) { Post.create(author:, title: 'Hello 1', text: 'This is my first post') }

  after(:all) do
    Like.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  describe 'method update_likes_count:' do
    context 'when adding 2 likes, the counter' do
      before do
        # An alternative to author.posts.create(...) is Post.create(...)
        2.times { post.likes.create(post:, author:) }
      end

      it { expect(post.likes.length).to eq(2) }

      after do
        # likes will be destroyed after(:all)
      end
    end
  end
end
