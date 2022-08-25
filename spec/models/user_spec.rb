require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:author) do
    user = User.new(name: 'Roberto', photo: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    bio: 'Teacher from Mexico.', email: 'roberto@mail.com')
    user.password = 'valido'
    user.password_confirmation = 'valido'
    user.confirm
    user
  end

  after(:all) do
    User.destroy_all
  end

  describe 'method recent_posts' do
    context 'returns a collection whose length' do
      before do
        # An alternative to author.posts.create(...) is Post.create(...)
        4.times { |i| author.posts.create(author:, title: 'Hello!', text: "This is my post # #{i}!") }
      end

      it { expect(author.recent_posts.length).to eq(3) }

      after do
        Post.destroy_all
        User.destroy_all
      end
    end
  end

  describe 'name must not be blank:' do
    context 'when is nil' do
      before { author.name = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is an empty string' do
      before { author.name = '' }

      it { is_expected.not_to be_valid }
    end

    context 'when is a blank string' do
      before { author.name = '            ' }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'PostsCounter must be an integer greater than or equal to zero:' do
    context 'when is nil' do
      before { author.posts_count = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when is decimal' do
      before { author.posts_count = 1.5 }

      it { is_expected.not_to be_valid }
    end

    context 'when is negative' do
      before { author.posts_count = -1 }

      it { is_expected.not_to be_valid }
    end
  end
end
