require 'rails_helper'

feature 'User creates a new job' do
  scenario 'successfully' do
    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    user2 = User.create(email: 'banana@locaweb.com',
                      password:   '12345678')


    company = Company.create(name: 'Campus Code',
                            location: 'São Paulo',
                            mail: 'contato@campus.com.br',
                            phone: '2369-3476',
                            user: user)

    company2 = Company.create(name: 'Locaweb',
                            location: 'São Paulo',
                            mail: 'contato@locaweb.com.br',
                            phone: '3470-4587',
                            user: user2)

    category = Category.create(name: 'Desenvolvedor')

    job = Job.new(title: 'Dev Master',
                  location: 'Rio de Janeiro',
                  category: category,
                  description: 'Vaga para Dev Master para Bootcamp Rails',
                  hiring_type: 'CLT')

    login(user.email, user.password)

    visit new_job_path

    expect(page).to_not have_content company2.name

    fill_in 'Title',       with: job.title
    fill_in 'Location',    with: job.location
    select category.name,  from: 'Category'
    select company.name,   from: 'Company'
    fill_in 'Description', with: job.description
    select job.hiring_type, from: 'Hiring type'

    click_on 'Criar Vaga'

    expect(page).to have_content job.title
    expect(page).to have_content job.location
    expect(page).to have_content job.category.name
    expect(page).to have_content company.name
    expect(page).to have_content job.description
    expect(page).to have_content job.hiring_type

  end

  scenario 'featured job' do
    user = User.create(email: 'queroserdev@locaweb.com',
                      password:   '12345678')

    company = Company.create(name: 'Campus Code',
                            location: 'São Paulo',
                            mail: 'contato@campus.com.br',
                            phone: '2369-3476',
                            user: user)

    category = Category.create(name: 'Desenvolvedor')

    job = Job.new(title:    'Dev Master',
                  location: 'Rio de Janeiro',
                  category: category,
                  description: 'Vaga para Dev Master para o Bootcamp Rails')

    login(user.email, user.password)

    visit new_job_path

    fill_in 'Title',       with: job.title
    fill_in 'Location',    with: job.location
    select category.name,  from: 'Category'
    select company.name,   from: 'Company'
    fill_in 'Description', with: job.description
    check   'Featured'

    click_on 'Criar Vaga'

    expect(page).to have_content job.title
    expect(page).to have_content job.location
    expect(page).to have_content job.category.name
    expect(page).to have_content company.name
    expect(page).to have_content job.description
    expect(page).to have_content 'Vaga em Destaque'
  end

  scenario 'invalid data' do

    login

    visit new_job_path

    click_on 'Criar Vaga'

    ['Title', 'Category', 'Description', 'Location'].each do |field|
      expect(page).to have_content "#{field} can\'t be blank"
    end

  end

  scenario 'unlogged user try to create job' do

    visit new_job_path

    expect(current_path).to eql new_user_session_path
    expect(page).to_not have_content 'Criar Vaga'

  end

end
