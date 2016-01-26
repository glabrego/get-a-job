class AddMailToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :mail, :string
  end
end
