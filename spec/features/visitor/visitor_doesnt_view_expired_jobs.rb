require 'rails_helper'

feature 'Visitor does not view expired jobs' do
  scenario 'successfully' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    category = Category.create(name: 'Desenvolvedor')

    job = nil
    travel_to 90.days.ago do
      job = create_job
    end

    job = nil
    travel_to 91.days.ago do
      job = Job.create(title: 'Full Stack',
                 description: 'Desenvolvedor Full Stack Rails',
                 location: 'São Paulo - SP',
                 company: company,
                 category: category)
    end

    visit root_path

      expect(page).to_not have_content('Desenvolvedor Rails')
      expect(page).to_not have_content('Full Stack')
  end

  scenario 'view not expired jobs' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    category = Category.create(name: 'Desenvolvedor')

    job = nil
    travel_to 89.days.ago do
      job = create_job
    end

    visit root_path

      expect(page).to have_content('Desenvolvedor Rails')
  end

  scenario 'view warning on details' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    category = Category.create(name: 'Desenvolvedor')

    job = nil
    travel_to 90.days.ago do
      job = create_job
    end

    visit job_path job

      expect(page).to have_content('Vaga Expirada!')
  end
end
