require 'rails_helper'

feature 'User area' do
    scenario 'successfully' do

      user = User.create(email: 'queroserdev@locaweb.com',
                        password:   '12345678')

      company = Company.create(name: 'Locaweb',
                            location: 'São Paulo',
                            mail: 'contato@campus.com.br',
                            phone: '2369-3476',
                            user: user)

      company2 = Company.create(name: 'Campus Code',
                            location: 'São Paulo',
                            mail: 'contato2@campus.com.br',
                            phone: '2369-3476',
                            user: user)


      category = Category.create(name: 'Desenvolvedor')

      job = Job.create(title: 'Dev Master',
                    location: 'Rio de Janeiro',
                    category: category,
                    description: 'Vaga para Dev Master para Bootcamp Rails',
                    hiring_type: 'CLT',
                    company: company,
                    user: user)

      login(user.email, user.password)

      visit dashboard_path(user)


      expect(page).to have_content 'Olá, queroserdev@locaweb.com'
      expect(page).to have_content 'Campus Code'
      expect(page).to have_content 'São Paulo'
      expect(page).to have_content 'contato@campus.com.br'
      expect(page).to have_content '2369-3476'
      expect(page).to have_content 'Desenvolvedor'
      expect(page).to have_content 'Dev Master'
      expect(page).to have_content 'Rio de Janeiro'
      expect(page).to have_content 'Vaga para Dev Master para Bootcamp Rails'

    end

    scenario 'and not see information from other users' do

      user = User.create(email: 'queroserdev@locaweb.com',
                        password:   '12345678')

      company = Company.create(name: 'Campus Code',
                            location: 'São Paulo',
                            mail: 'contato@campus.com.br',
                            phone: '2369-3476',
                            user: user)

      category = Category.create(name: 'Desenvolvedor')

      job = Job.new(title: 'Dev Master',
                    location: 'Rio de Janeiro',
                    category: category,
                    description: 'Vaga para Dev Master para Bootcamp Rails',
                    hiring_type: 'CLT',
                    company: company,
                    user: user)

      user2 = User.create(email: 'hacker@locaweb.com',
                                  password:   '25632165')

      login(user2.email, user2.password)

      visit dashboard_path(user)

      expect(current_path).to_not eql dashboard_path(user)


    end
end
