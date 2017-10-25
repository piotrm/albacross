class DepartmentParamsSanitizer < InputSanitizer::Sanitizer
  string :dept_no, required: true
  custom :page, converter: InputSanitizer::PositiveIntegerConverter.new
  custom :per_page, converter: InputSanitizer::PositiveIntegerConverter.new
end
