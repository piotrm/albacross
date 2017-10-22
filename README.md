# albacross
## backend-recruitment-task

-> https://github.com/piotrm/albacross/commit/455f9496ae59d1080507bfa1a2cad381b57ed5fc
- Generates schema.rb from external DB's schema by `rake db:schema:dump` to make sure the schema does not get out of sync during cumbersome migrations' creation process
- Adds `native_enum` gem to enable MySQL's __enum__ type that is not handled natively by Rails

-> https://github.com/piotrm/albacross/commit/0c177d7cae5ea10dd7f75c9c06d3d3fa0fe5a0a8
- Adds `composite_primary_keys` gem to enable composite primary keys for DeptEmp and DeptManager
