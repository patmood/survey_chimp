class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :completed_surveys
  has_many :questions

  validates :title, :presence => :true
end
