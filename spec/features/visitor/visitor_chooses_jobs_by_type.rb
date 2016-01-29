require 'rails_helper'

feature 'Visitor chooses Job by type' do
  scenario 'successfully' do
    category = Category.new(name: 'Sei la')

    company =  Company.create(name: 'Campus Code',
                       location: 'São Paulo',
                       phone: '11 2369 3476',
                       mail: 'contato@campuscode.com.br')

    job = Job.create(title: 'Desenvolvedor Rails',
               description: 'Desenvolvedor Full Stack Rails',
               location: 'São Paulo - SP',
               hiring_type: 'PJ',
               category: category,
               company: company)

    job_2 = Job.create(title: 'Desenvolvedor Java',
               description: 'Java7',
               location: 'Maceio',
               hiring_type: 'PJ',
               category: category,
               company: company)

    visit root_path

    click_on 'PJ'

    expect(page).to have_content job.title
    expect(page).to have_content job.category.name
    expect(page).to have_content job.description
    expect(page).to have_content job.location

    expect(page).to have_content job_2.title
    expect(page).to have_content job_2.category.name
    expect(page).to have_content job_2.description
    expect(page).to have_content job_2.location
  end

  scenario 'and does not see other hiring jobs' do
    category = Category.new(name: 'Sei la')
    category2 = Category.new(name: 'Nao sabemos')

    company =  Company.create(name: 'Campus Code',
                       location: 'São Paulo',
                       phone: '11 2369 3476',
                       mail: 'contato@campuscode.com.br')

    job = Job.create(title: 'Desenvolvedor Rails',
               description: 'Desenvolvedor Full Stack Rails',
               location: 'São Paulo - SP',
               hiring_type: 'Freelancer',
               category: category,
               company: company)

    job_2 = Job.create(title: 'Desenvolvedor C#',
               description: 'Senior C#',
               location: 'RIO',
               hiring_type: 'CLT',
               category: category2,
               company: company)

   visit root_path

   click_on 'Freelancer'

   expect(page).to have_content job.title
   expect(page).to have_content job.category.name
   expect(page).to have_content job.description
   expect(page).to have_content job.location

   expect(page).to_not have_content job_2.title
   expect(page).to_not have_content job_2.category.name
   expect(page).to_not have_content job_2.description
   expect(page).to_not have_content job_2.location



  end
end
