require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:author) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
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
