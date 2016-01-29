require 'rails_helper'

feature 'User creates a new company' do

  scenario 'successfully' do
    company = Company.new(name:     'Campus Code',
                          location: 'São Paulo',
                          mail:     'contato@campuscode.com.br',
                          phone:    '2369-3476')

    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_company_path

    fill_in 'Name',     with: company.name
    fill_in 'Location', with: company.location
    fill_in 'Mail',     with: company.mail
    fill_in 'Phone',    with: company.phone

    click_on 'Criar Empresa'

    expect(page).to have_content company.name
    expect(page).to have_content company.location
    expect(page).to have_content company.mail
    expect(page).to have_content company.phone
  end

  scenario 'invalid' do

    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    visit new_company_path
    click_on 'Criar Empresa'

    expect(page).to have_content "Warning! All fields are mandatory."
  end

  scenario 'unlogged user try to create company' do

    visit new_company_path

    expect(page).to have_content 'Log in'
    expect(page).to_not have_content 'Criar Empresa'
  end
end
