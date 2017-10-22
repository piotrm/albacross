class TitleSerializer < ActiveModel::Serializer
  attributes :emp_no, :title, :from_date, :to_date

  belongs_to :employee
end
