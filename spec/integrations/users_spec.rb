require 'rails_helper'

RSpec.describe 'Users', type: :system do
  subject!(:author) { User.where(name: 'Tom').first }
  subject!(:lilly) { User.where(name: 'Lilly').first }
  let!(:post) { Post.where(title: 'Hello 3').first }

  before(:all) do
    Rails.application.load_seed
  end

  after(:all) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  describe 'index page:' do
    before(:example) do
      visit users_path
    end

    it 'shows the name of all authors' do
      expect(page).to have_content('Roberto')
      expect(page).to have_content(author.name)
      expect(page).to have_content(lilly.name)
    end

    it 'shows the profile picture of all authors' do
      image = page.all('img')
      expect(image.size).to eq(3)
    end

    it 'shows the number of posts for each author' do
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_content('Number of posts: 0')
    end

    it 'redirects to the author\'s show page when clicked on the link' do
      first(:link, lilly.name).click
      expect(page).to have_current_path user_path(lilly.id)
      expect(page).to have_content(lilly.bio)
    end
  end

  describe 'show page:' do
    before(:example) do
      visit user_path(author.id)
    end

    it 'shows the author\'s profile picture' do
      image = page.all('img')
      expect(image.size).to eq(1)
    end

    it 'shows the author\'s number of posts' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'shows author\'s bio' do
      expect(page).to have_content(author.bio)
    end

    it 'shows the author\'s three most recent posts' do
      posts = page.all('.post')
      expect(posts.size).to eq(3)
    end

    it 'shows a link to the author\'s posts\'s index page' do
      expect(page).to have_link(nil, href: user_posts_path(author.id))
    end

    it 'redirects to post\'s show page when clicked the link' do
      click_on post.title
      expect(page).to have_current_path user_post_path(author.id, post.id)
    end

    it 'redirects to post\'s index page when clicked the link' do
      first(:link, 'See all posts').click
      expect(page).to have_current_path user_posts_path(author.id)
    end
  end
end
