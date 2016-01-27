class Company < ActiveRecord::Base
  has_many :jobs
  validates :name, :location, :mail, :phone, presence: true

  def premium?
    self.jobs.count >= 5
  end
end
