class DepartmentManager < ApplicationRecord
  self.table_name = "dept_manager"
  self.primary_keys = :emp_no, :dept_no

  belongs_to :department, foreign_key: "dept_no"
  belongs_to :employee, foreign_key: "emp_no"
end
