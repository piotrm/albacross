class EmployeeSerializer < ActiveModel::Serializer
  attributes :emp_no, :first_name, :last_name, :birth_date, :gender

  has_many :departments
  has_many :salaries
  has_many :titles
end
