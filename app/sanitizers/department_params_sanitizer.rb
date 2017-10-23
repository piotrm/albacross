class DepartmentParamsSanitizer < InputSanitizer::Sanitizer
  integer :page
  integer :per_page
  string :dept_no, required: true
end
