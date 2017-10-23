def build_employee_with_relations(options = {})
  employee = FactoryGirl.create(:employee, options[:employee])
  department = FactoryGirl.create(:department, options[:department])
  FactoryGirl.create(:department_employee,
    { dept_no: department.dept_no, emp_no: employee.emp_no } )
  salary_options = { emp_no: employee.emp_no }.merge(options[:salary] || {})
  FactoryGirl.create(:salary, salary_options)
  title_options = { emp_no: employee.emp_no }.merge(options[:title] || {})
  FactoryGirl.create(:title, title_options )
  employee
end

def build_active_employee_stats(emp_no)
  {
    emp_no: emp_no,
    clicks: 10,
    views: 10
  }
end
