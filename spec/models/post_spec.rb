require 'rails_helper'

RSpec.describe Post, type: :model do
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
    Post.destroy_all
    User.destroy_all
  end

  describe 'method recent_comments' do
    context 'returns a collection whose length' do
      before do
        # An alternative to post.coments.create(...) is Comment.create(...)
        6.times { |i| post.comments.create(post:, author:, text: "Hi Tom #{i}!") }
      end

      it { expect(post.recent_comments.length).to eq(5) }

      after do
        Comment.destroy_all
      end
    end
  end

  describe 'method update_posts_count:' do
    context 'when adding 2 posts, the counter' do
      before do
        # An alternative to author.posts.create(...) is Post.create(...)
        2.times { |i| author.posts.create(author:, title: 'Hello!', text: "This is my post # #{i + 1}!") }
      end

      it { expect(author.posts.length).to eq(2) }

      after do
        # comments will be destroyed after(:all)
      end
    end
  end

  describe 'title must not be blank:' do
    context 'when is nil' do
      before { post.title = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is an empty string' do
      before { post.title = '' }

      it { is_expected.not_to be_valid }
    end

    context 'when is a blank string' do
      before { post.title = '       ' }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'Title must not exceed 250 characters:' do
    context 'when length is 251' do
      before { post.title = '-' * 251 }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'ComentsCounter must be an integer greater than or equal to zero:' do
    context 'when is nil' do
      before { post.comments_count = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is decimal' do
      before { post.comments_count = 1.5 }

      it { is_expected.not_to be_valid }
    end

    context 'when is negative' do
      before { post.comments_count = -1 }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'LikesCounter must be an integer greater than or equal to zero:' do
    context 'when is nil' do
      before { post.likes_count = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is decimal' do
      before { post.likes_count = 1.5 }

      it { is_expected.not_to be_valid }
    end

    context 'when is negative' do
      before { post.likes_count = -1 }

      it { is_expected.not_to be_valid }
    end
  end
end
