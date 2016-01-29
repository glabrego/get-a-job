require 'rails_helper'

feature 'User edits a company' do
  scenario 'successfully' do

    user1 = User.create(email: 'teste@teste.com', password: '12345678')
    user2 = User.create(email: 'teste2@teste.com', password: '123#@678')

    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             phone:    '2369-3476',
                             mail:     'contato@campuscode.com.br',
                             user: user1 )

    login(user1.email, user1.password)

    visit edit_company_path(company)

    fill_in 'Name',     with: 'Code Campus'
    fill_in 'Location', with: 'Recife'
    fill_in 'Mail',     with: 'contat@codecampus.com.br'
    fill_in 'Phone',    with: '1111-5555'

    click_on 'Atualizar Empresa'

    expect(current_path).to eql company_path(company)
    expect(page).to have_content 'Code Campus'
    expect(page).to have_content 'Recife'
    expect(page).to have_content 'contat@codecampus.com.br'
    expect(page).to have_content '1111-5555'
  end

  scenario 'and other users cannot edit my companies' do

    user1 = User.create(email: 'teste@teste.com', password: '12345678')
    user2 = User.create(email: 'teste2@teste.com', password: '123#@678')


    company1 = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             phone:    '2369-3476',
                             mail:     'contato@campuscode.com.br',
                             user: user1)

    login(user2.email, user2.password)

    visit edit_company_path(company1)

    expect(current_path).to_not eql edit_company_path(company1)
    expect(current_path).to eql root_path
    expect(page).to have_content 'You are not allowed to edit that company!'
  end
end
