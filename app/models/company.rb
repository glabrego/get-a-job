class Company < ActiveRecord::Base
  belongs_to :user
  has_many :jobs
  validates :name, :location, :mail, :phone, presence: true

  def premium?
      self.jobs.count >= 5
  end
end
