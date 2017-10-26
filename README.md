# Albacross - backend-recruitment-task [![Build Status](https://travis-ci.org/piotrm/albacross.svg?branch=master)](https://travis-ci.org/piotrm/albacross)

## Testing the solution
The solution has been deployed to Heroku, therefore there is no need to set it up locally in order to see the results.

### Swagger
There is a description for the API prepared in swagger that can be found here:
https://app.swaggerhub.com/apis/pmatuszkiewicz/AlbacrossAPI/1.0.0

Swagger has a feature that allows to test the API with provided parameters straight from the documentation. In order to do it:
1. Select the endpoint
2. Press "Try it out"
3. Provide parameters
4. Execute

### Browser
The response from the endpoints is also available via browser under: http://albacrossrecru.herokuapp.com/api/v1/

### cURL
Third option is to use cURL.

With headers:
```
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET https://albacrossrecru.herokuapp.com/api/v1/employees\?page\=1&per_page\=15&salary_from\=50000&salary_to=54000
```

```
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET https://albacrossrecru.herokuapp.com/api/v1/departments/d009/active_employees\?page\=1
```

Without headers (pretty print works on OS X):
```
curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET  https://albacrossrecru.herokuapp.com/api/v1/departments/d005/active_employees | python -mjson.tool
```

## Progress Log

-> https://github.com/piotrm/albacross/commit/455f9496ae59d1080507bfa1a2cad381b57ed5fc
- Generates schema.rb from external DB's schema by `rake db:schema:dump` to make sure the schema does not get out of sync during cumbersome migrations' creation process
- Adds `native_enum` gem to enable MySQL's __enum__ type that is not handled natively by Rails



-> https://github.com/piotrm/albacross/commit/0c177d7cae5ea10dd7f75c9c06d3d3fa0fe5a0a8
- Adds `composite_primary_keys` gem to enable composite primary keys for DeptEmp and DeptManager



-> https://github.com/piotrm/albacross/commit/f04b642802b6dff6c2a21c26412190a7c3d1a7d0
- Sets `has_many :through` association only for __Department - DeptEmp - Employee__ trio, not for __Department - DeptManager - Employee__ because Rails does not allow multiple `has_many :through` associations between two models (e.g. __Department/Employee__) - it raises `ActiveRecord::HasManyThroughOrderError`
- Creates __DepartmentEmployee__ model for __DeptEmp__ table and __DepartmentManager__ for __DeptManager__ table, breaking Convention over Configuration paradigm in the context of model naming for the sake of clarity. It is worth mentioning that the conventional naming (__DeptEmp/DeptManager__) would not work out of the box, because the tables in the external DB are named __dept_emp__ and __dept_manager__ and Rails would look for plurals - __dept_emps__ and __dept_managers__.



-> https://github.com/piotrm/albacross/commit/9ce7e98a59c90017ce716e3dc0340d73ba229cda
- Changes the source of `native_enum` gem to the fork that consist of a fix for Rails 5.0. Using gem from __rubygems__ causes incorrect limit interpretation during dev / test DB creation, making specs unusable.



-> https://github.com/piotrm/albacross/commit/4dfa91c15a95c963d6ca9a37a71d47f9d04f32af
- Exposes endpoint that allows to fetch __Employees__ along with __Departments__, __Titles__ and __Salaries__. It allows to fetch both all of the Employees (with pagination - either with specified `page` / `per_page` prams or with default ones `page: 1` and `per_page: 10`) and Employees filtered by the salary range by providing `salary_from` or/and `salary_to` parameters.
- Initial concept circled around making the enpoint compliant with the __json:api__ spec, but it then turned out that with given DB schema it is impossible because one of the major requirements of __json:api__ is to have `:id` which is obviously missing. Ultimately, the API's response is close to what __json:api__ offers, with similar structure and amount of meta-information.
- The logic responsible for fetching the data has been moved to `FetchEmployees` service object in order to keep the controller lightweight.
- `input_sanitizer` gem helps to ensure that the parameters' format is proper.


-> https://github.com/piotrm/albacross/commit/9ee75bd19452cc1f57a113741fd9a91fd2571bc2
- Exposes endpoint that allows to fetch __active__ __Employees__ along with __Departments__, __Titles__ and __Salaries__. Active, because there are recorded activities (clicks, views) for them. Also in this case the pagination has been implemented. The response is formated in the same manner as in case of /api/v1/employees.
- The logic responsible for fetching the employees is located in `FetchActiveEmployees` service object.
- The logic responsible for retrieving stats from Elasticsearch is located in `SeekEmployeeStat` service object, not to make mess in the Department model. I am not the fan of "fat model, skinny controller" approach - I prefer moving responsibilites to other class (libs, service objects, domain classes etc.)


-> https://github.com/piotrm/albacross/commit/28d13e0848c10888264827f4643f31b39db434d1
- Moves ResponseFormatter from __/lib__ to __app/lib__ in order to leverage file autoloading on production environment


-> https://github.com/piotrm/albacross/commit/b8d0fef61cf9e9097344397adb07b8e1cd4afc56
- Replaces hardcoded Elasticsearch host for ENV variable - in the same manner as in case of DB credentials.


-> https://github.com/piotrm/albacross/commit/8851e216656950e59ae369d31a2ac697d56f01a1
- Sets additional constraints on `page` and `per_page` parameters - they has to be positive integers. In case there will be 0 or less than 0 the endpoints will return `400 Bad Request`. In order to set the constraints `input_sanitizer` gem is used.
