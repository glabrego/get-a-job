class RemoveEmailFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :email, :string
  end
end
