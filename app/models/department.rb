class Department < ApplicationRecord
  has_many :department_employees, primary_key: "dept_no", foreign_key: "dept_no"
  has_many :employees, through: :department_employees

  has_many :department_managers, primary_key: "dept_no", foreign_key: "dept_no"
end
