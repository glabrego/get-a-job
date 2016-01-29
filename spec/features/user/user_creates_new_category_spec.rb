require 'rails_helper'

feature 'User creates a new category' do

  scenario 'successfully' do
    category = Category.new(name: 'Desenvolvedor')

    login

    visit new_category_path

    fill_in 'Name',     with: category.name
    click_on 'Criar Categoria'

    expect(page).to have_content category.name
  end

  scenario 'invalid' do
    login

    visit new_category_path
    click_on 'Criar Categoria'


    expect(page).to have_content "Warning! All fields are mandatory."
  end

  scenario 'unlogged user try to create category' do

    visit new_category_path

    expect(page).to have_content 'Log in'
    expect(page).to_not have_content 'Criar Categoria'

  end
end
