class University < ActiveRecord::Base
  has_many :courses
  has_many :departments
end
