class Department < ApplicationRecord
  include Elasticsearch::Model
  validates :dept_name, presence: true, length: { maximum: 40 }

  has_many :department_employees, primary_key: "dept_no", foreign_key: "dept_no"
  has_many :employees, through: :department_employees
  has_many :department_managers, primary_key: "dept_no", foreign_key: "dept_no"

  index_name "department"
  document_type "stats"
end
