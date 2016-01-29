class AddHiringTypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :hiring_type, :string
  end
end
