require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let!(:author) { User.where(name: 'Tom').first }
  let!(:lilly) { User.where(name: 'Lilly').first }
  subject!(:post) { Post.where(title: 'Hello 3').first }
  let!(:comment) { Comment.where(text: 'Hi Tom 4!').first }

  before(:all) do
    Rails.application.load_seed
    driven_by(:selenium_chrome_headless)
  end

  after(:all) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  describe 'index page:' do
    before(:example) do
      visit user_posts_path(author.id)
    end

    it 'shows the author\'s profile picture' do
      image = page.all('img')
      expect(image.size).to eq(1)
    end

    it 'shows the author\'s name' do
      expect(page).to have_content(author.name)
    end

    it 'shows the author\'s number of posts' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'shows post\'s title' do
      expect(page).to have_content(post.title)
    end
  end
end
