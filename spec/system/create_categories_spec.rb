require 'rails_helper'

RSpec.describe 'Creating Categories', driver: :selenium_chrome, js: true do
  describe 'Viewing all Categories' do
    it 'shows all categories in index page' do
      visit categories_path
      within 'body' do
        expect(page).to have_content('Categories')
        expect(page).to have_link('New Category')
        sleep(2)
      end
    end
  end

  describe 'Creating a valid Category' do
    it 'successfully creates a new category' do
      visit categories_path
      click_on 'New Category'
      expect(page).to have_current_path new_category_path
      within 'form' do
        fill_in 'Title', with: 'title'
        fill_in 'Description', with: 'description'
        click_on 'Create Category'
        sleep(3)
      end
      expect(page).to have_content('title')
      expect(page).to have_content('description')
      expect(page).to have_text('Category was successfully created')
      sleep(3)
      category = Category.order('id').last
      expect(category.title).to eq('title')
      expect(category.description).to eq('description')
    end
  end

  describe 'Creating an invalid Category' do
    it 'is invalid without a title' do
      visit '/categories/new'
      fill_in 'Title', with: ''
      click_on 'Create Category'
      expect(page).to have_text("Title can't be blank")
      sleep(3)
    end

    it 'is invalid without a description' do
      visit '/categories/new'
      fill_in 'Description', with: ''
      click_on 'Create Category'
      expect(page).to have_text("Description can't be blank")
      sleep(3)
    end
  end
end
