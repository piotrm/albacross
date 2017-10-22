require 'factory_girl'

FactoryGirl.define do
  factory :department do
    sequence(:dept_no)
    sequence(:dept_name) do |n|
      (Faker::Commerce.department+"#{n}").truncate(40)
    end
  end

  factory :department_employee do
    sequence(:emp_no)
    dept_no { "d001" }
    from_date { Date.today-10.days }
    to_date { Date.today+10.days }
  end

  factory :department_manager do
    sequence(:emp_no)
    dept_no { "d001" }
    from_date { Date.today-10.days }
    to_date { Date.today+10.days }
  end

  factory :employee do
    sequence(:emp_no)
    birth_date { Date.parse("1988-01-01") }
    first_name { Faker::Name.first_name.truncate(14) }
    last_name { Faker::Name.last_name.truncate(16) }
    gender { "M" }
    hire_date { Date.today-10.days }
  end

  factory :salary do
    sequence(:emp_no)
    salary { rand(1..10000) }
    from_date { Date.today-10.days }
    to_date { Date.today+10.days }
  end

  factory :title do
    sequence(:emp_no)
    title { Faker::Company.profession.truncate(50) }
    from_date { Date.today-10.days }
    to_date { Date.today+10.days }
  end
end
