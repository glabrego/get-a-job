require 'rails_helper'

feature 'User creates a new job' do

  scenario 'successfully' do
    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')
    company = Company.create(name:    'Campus Code',
                            location: 'São Paulo',
                            mail:     'contato@campuscode.com.br',
                            phone:    '2369-3476',
                            user: user)

    new_company = Company.create(name:     'Code Campus',
                                 location: 'Refice',
                                 mail:     'contato@codecampus.com.br',
                                 phone:    '1111-5555',
                                 user: user)

    category = Category.create(name: 'Desenvolvedor')

    new_category = Category.create(name: 'Dev Ninja')

    job = Job.create(title: 'Vaga de Dev',
               description: 'Dev Junior Rails com ao menos um projeto',
               location: 'São Paulo',
               company: company,
               category: category,
               user: user)

    login(user.email, user.password)

    visit edit_job_path(job)

    fill_in 'Title',       with: 'Dev Mais que Master'
    fill_in 'Location',    with: 'Recife'
    select  new_company.name
    select  new_category.name
    fill_in 'Description', with: 'Vaga para Dev Mais que Master para o Quickstart'

    click_on 'Atualizar Vaga'

    expect(page).to have_content 'Dev Mais que Master'
    expect(page).to have_content 'Recife'
    expect(page).to have_content 'Dev Ninja'
    expect(page).to have_content 'Code Campus'
    expect(page).to have_content 'Vaga para Dev Mais que Master para o Quickstart'
  end

  scenario 'featured job' do
    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    company = Company.create(name:     'Campus Code',
                            location: 'São Paulo',
                            mail:     'contato@campuscode.com.br',
                            phone:    '2369-3476',
                            user: user)

    category = Category.create(name: 'Desenvolvedor')

    job = Job.create(title: 'Vaga de Dev',
               description: 'Dev Junior Rails com ao menos um projeto',
               location:    'São Paulo',
               company:  company,
               category: category,
               user: user,
               featured:    false)

    login(user.email, user.password)

    visit edit_job_path(job)

    fill_in 'Title',       with: 'Dev Mais que Master'
    fill_in 'Location',    with: 'Recife'
    select  'Campus Code'
    select  'Desenvolvedor'
    fill_in 'Description', with: 'Vaga para Dev Mais que Master para o Quickstart'
    check   'Featured'

    click_on 'Atualizar Vaga'

    expect(page).to have_content 'Dev Mais que Master'
    expect(page).to have_content 'Recife'
    expect(page).to have_content 'Desenvolvedor'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Vaga para Dev Mais que Master para o Quickstart'
    expect(page).to have_content 'Vaga em Destaque'
  end

  scenario "and other users doesn't edit my jobs" do
    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    company = Company.create(name:     'Campus Code',
                            location: 'São Paulo',
                            mail:     'contato@campuscode.com.br',
                            phone:    '2369-3476',
                            user: user)

    category = Category.create(name: 'Desenvolvedor')

    job = Job.create(title: 'Vaga de Dev',
               description: 'Dev Junior Rails com ao menos um projeto',
               location:    'São Paulo',
               company:  company,
               category: category,
               user: user,
               featured:    false)

     user2 = User.create(email: 'hacker@locaweb.com',
                       password:   '98675644')

    login(user2.email, user2.password)

    visit edit_job_path(job)

    expect(current_path).to_not eql edit_job_path(job)
    expect(page).to have_content 'You are not allowed to edit that job!'
  end


end
