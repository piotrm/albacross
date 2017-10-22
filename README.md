# albacross
## backend-recruitment-task

-> https://github.com/piotrm/albacross/commit/455f9496ae59d1080507bfa1a2cad381b57ed5fc
- Generates schema.rb from external DB's schema by `rake db:schema:dump` to make sure the schema does not get out of sync during cumbersome migrations' creation process
- Adds `native_enum` gem to enable MySQL's __enum__ type that is not handled natively by Rails

-> https://github.com/piotrm/albacross/commit/0c177d7cae5ea10dd7f75c9c06d3d3fa0fe5a0a8
- Adds `composite_primary_keys` gem to enable composite primary keys for DeptEmp and DeptManager

-> https://github.com/piotrm/albacross/commit/f04b642802b6dff6c2a21c26412190a7c3d1a7d0
- Sets `has_many :through` association only for __Department - DeptEmp - Employee__ trio, not for __Department - DeptManager - Employee__ because Rails does not allow multiple `has_many :through` associations between two models (e.g. __Department/Employee__) - it raises `ActiveRecord::HasManyThroughOrderError`
- Creates __DepartmentEmployee__ model for __DeptEmp__ table and __DepartmentManager__ for __DeptManager__ table, breaking Convention over Configuration paradigm in the context of model naming for the sake of clarity. It is worth mentioning that the conventional naming (__DeptEmp/DeptManager__) would not work out of the box, because the tables in the external DB are named __dept_emp__ and __dept_manager__ and Rails would look for plurals - __dept_emps__ and __dept_managers__.
