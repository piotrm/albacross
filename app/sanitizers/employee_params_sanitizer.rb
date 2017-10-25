class EmployeeParamsSanitizer < InputSanitizer::Sanitizer
  integer :salary_from
  integer :salary_to
  custom :page, converter: InputSanitizer::PositiveIntegerConverter.new
  custom :per_page, converter: InputSanitizer::PositiveIntegerConverter.new
end