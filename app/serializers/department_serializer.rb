class DepartmentSerializer < ActiveModel::Serializer
  attributes :dept_no, :dept_name

  has_many :employees
end
