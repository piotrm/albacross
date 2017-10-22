require 'rails_helper'

describe Department do
  let(:klass) { described_class }

  describe "relationships" do
    it "has many DepartmentEmployees" do
      expect(klass.reflect_on_association(:department_employees).macro).to eq(:has_many)
    end

    it "has many Employees" do
      expect(klass.reflect_on_association(:employees).macro).to eq(:has_many)
    end

    it "has many DepartmentManagers" do
      expect(klass.reflect_on_association(:department_managers).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    context "with all correct parameters" do
      it "is valid" do
        department = FactoryGirl.build(:department)
        expect(department.valid?).to be true
      end
    end

    context "with missing dept name" do
      it "is invalid" do
        department = FactoryGirl.build(:department, dept_name: nil)
        expect(department.valid?).to be false
      end
    end

    context "with too long dept name" do
      it "is invalid" do
        name = "X"*100
        employee = FactoryGirl.build(:department, dept_name: name)
        expect(employee.valid?).to be false
      end
    end
  end
end
