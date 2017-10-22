class DepartmentManager < ApplicationRecord
  self.table_name = "dept_manager"
  self.primary_keys = :emp_no, :dept_no

  validates :emp_no, :from_date, :to_date, presence: true
  validates :dept_no, presence: true, length: { maximum: 4 }

  belongs_to :department, foreign_key: "dept_no"
  belongs_to :employee, foreign_key: "emp_no"
end
