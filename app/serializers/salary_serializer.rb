class SalarySerializer < ActiveModel::Serializer
  attributes :emp_no, :salary, :from_date, :to_date

  belongs_to :employee
end
