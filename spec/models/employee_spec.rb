require 'rails_helper'

describe Employee do
  let(:klass) { described_class }

  describe "relationships" do
    it "has many DepartmentEmployees" do
      expect(klass.reflect_on_association(:department_employees).macro).to eq(:has_many)
    end

    it "has many Departments" do
      expect(klass.reflect_on_association(:departments).macro).to eq(:has_many)
    end

    it "has many DepartmentManagers" do
      expect(klass.reflect_on_association(:department_managers).macro).to eq(:has_many)
    end

    it "has many Titles" do
      expect(klass.reflect_on_association(:titles).macro).to eq(:has_many)
    end

    it "has many Salaries" do
      expect(klass.reflect_on_association(:salaries).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    context "with all correct parameters" do
      it "is valid" do
        employee = FactoryGirl.build(:employee)
        expect(employee.valid?).to be true
      end
    end

    context "with missing birth date" do
      it "is invalid" do
        employee = FactoryGirl.build(:employee, birth_date: nil)
        expect(employee.valid?).to be false
      end
    end

    context "with missing first name" do
      it "is invalid" do
        employee = FactoryGirl.build(:employee, first_name: nil)
        expect(employee.valid?).to be false
      end
    end

    context "with too long first name" do
      it "is invalid" do
        name = ("a".."z").to_a.join
        employee = FactoryGirl.build(:employee, first_name: name)
        expect(employee.valid?).to be false
      end
    end

    context "with missing last name" do
      it "is invalid" do
        employee = FactoryGirl.build(:employee, last_name: nil)
        expect(employee.valid?).to be false
      end
    end

    context "with too long last name" do
      it "is invalid" do
        name = ("a".."z").to_a.join
        employee = FactoryGirl.build(:employee, last_name: name)
        expect(employee.valid?).to be false
      end
    end

    context "with missing gender" do
      it "is invalid" do
        employee = FactoryGirl.build(:employee, gender: nil)
        expect(employee.valid?).to be false
      end
    end

    context "with incorrect gender" do
      it "is invalid" do
        gender = "X"
        employee = FactoryGirl.build(:employee, gender: gender)
        expect(employee.valid?).to be false
      end
    end

    context "with missing hire date" do
      it "is invalid" do
        employee = FactoryGirl.build(:employee, hire_date: nil)
        expect(employee.valid?).to be false
      end
    end
  end
end
