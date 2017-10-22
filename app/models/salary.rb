class Salary < ApplicationRecord
  validates :emp_no, :salary, :from_date, :to_date, presence: true

  belongs_to :employee, foreign_key: "emp_no"
end
