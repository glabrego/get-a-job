module ModelsMacros
  def create_company
    Company.create(name: 'Campus Code',
                   location: 'São Paulo',
                   phone: '11 2369 3476',
                   mail: 'contato@campuscode.com.br')
  end

  def create_category
    Category.create(name: 'Desenvolvedor')
  end

  def create_job(company = nil, category = nil)
    company ||= create_company
    category ||= create_category
    company.jobs.create(title: 'Desenvolvedor Rails',
               description: 'Desenvolvedor Full Stack Rails',
               location: 'São Paulo - SP',
               hiring_type: 'Freelancer',
               category: category)
  end

  def login(email = nil, password = nil)
    email ||= 'queroserdev@locaweb.com'
    password ||= '12345678'
    user = User.create(email: email,
                      password: password  )

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end
end
