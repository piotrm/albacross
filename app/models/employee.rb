class Employee < ApplicationRecord
  has_many :department_employees, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :departments, through: :department_employees
  has_many :department_managers, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :titles, primary_key: "emp_no", foreign_key: "emp_no"
  has_many :salaries, primary_key: "emp_no", foreign_key: "emp_no"
end
