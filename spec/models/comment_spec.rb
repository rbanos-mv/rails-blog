require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.create(name: 'Tom', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', bio: 'Teacher from Mexico.') }
  subject(:post) { Post.create(author:, title: 'Hello 1', text: 'This is my first post') }

  after(:all) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  describe 'method update_comments_count:' do
    context 'when adding 2 comments, the counter' do
      before do
        # An alternative to author.posts.create(...) is Post.create(...)
        2.times { |i| post.comments.create(post:, author:, text: "Hi Tom #{i + 1}!") }
      end

      it { expect(post.comments.length).to eq(2) }

      after do
        # comments will be destroyed after(:all)
      end
    end
  end
end
