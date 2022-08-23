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

    it 'shows part of the post\'s text' do
      expect(page).to have_content(post.text[0..50])
    end

    it 'shows the last five comments on a post' do
      expect(page).to have_content(comment.text)
    end

    it 'shows the post\'s number of comments' do
      expect(page).to have_content('Comments: 6')
    end

    it 'shows the post\'s number of likes' do
      expect(page).to have_content('Likes: 0')
    end

    it 'has pagination button' do
      expect(page).to have_content('Pagination')
    end

    it 'redirects to post\'s show page when clicking on the title' do
      click_link(post.title)
      expect(page).to have_current_path user_post_path(author.id, post.id)
      expect(page).to have_content(post.title)
    end
  end

  describe 'show page:' do
    before(:example) do
      visit user_post_path(author.id, post.id)
    end

    it 'shows post\'s title' do
      expect(page).to have_content(post.title)
    end

    it 'shows post\'s author name' do
      expect(page).to have_content(author.name)
    end
end
