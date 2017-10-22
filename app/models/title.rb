class Title < ApplicationRecord
  self.primary_keys = :emp_no, :title, :from_date

  validates :emp_no, :from_date, :to_date, presence: true
  validates :title, presence: true, length: { maximum: 50 }

  belongs_to :employee, foreign_key: "emp_no"
end
