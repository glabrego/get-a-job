class Job < ActiveRecord::Base
  belongs_to :company
  validates :title, :location, :category, :description, :company_id, presence: true
end
