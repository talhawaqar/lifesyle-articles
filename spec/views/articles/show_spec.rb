# rubocop:disable Layout/LineLength

require 'rails_helper'
RSpec.describe 'Show Article', type: :feature do
  file = Rails.root.join('spec', 'test_img.jpg')
  image = ActiveStorage::Blob.create_after_upload!(
    io: File.open(file, 'rb'),
    filename: 'test_img.jpg',
    content_type: 'image/jpg' # Or figure it out from `name` if you have non-JPEGs
  ).signed_id

  let!(:user) do
    User.create(email: 'dev@ugobensaid.test', username: 'webdev', password: '123456')
  end
  let!(:category) { Category.create(name: 'test cat', priority: 1) }

  let!(:article) do
    Article.create(title: 'test 1', text: 'test 1 test', article_image: image, categories: [category], author_id: user.id)
  end

  DatabaseCleaner.start

  it 'Show Article' do
    visit article_path(article.id)
    expect(page).to have_content('test 1')
  end

  DatabaseCleaner.clean
end

# rubocop:enable Layout/LineLength
