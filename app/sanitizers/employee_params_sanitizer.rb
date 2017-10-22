class EmployeeParamsSanitizer < InputSanitizer::Sanitizer
  integer :page
  integer :per_page
  integer :salary_from
  integer :salary_to
end