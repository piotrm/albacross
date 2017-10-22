class Employee < ApplicationRecord
  validates :birth_date, :hire_date, presence: true
  validates :gender, presence: true, inclusion: { in: %w{M F} }
  validates :first_name, presence: true, length: { maximum: 14 }
  validates :last_name, presence: true, length: { maximum: 16 }

  has_many :department_employees, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :departments, through: :department_employees
  has_many :department_managers, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :titles, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :salaries, primary_key: "emp_no", foreign_key: "emp_no"
end
