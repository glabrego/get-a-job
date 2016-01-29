require 'rails_helper'

feature 'User login on application' do

  scenario 'successfully' do

    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    expect(page).to have_content 'Olá, '+user.email
  end

  scenario  'user cannot enter with wrong password' do

    user = User.create(email: 'queroserdev@locaweb.com',
    password:   '12345678')

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: '987654321'

    click_on 'Log in'

    expect(page).to_not have_content 'Olá, '+user.email
    expect(page).to have_content 'Invalid'
  end

  scenario  'user cannot enter without values' do


    visit new_user_session_path

    click_on 'Log in'

    expect(page).to_not have_content 'Olá, '
    expect(page).to have_content 'Invalid'
  end

end
