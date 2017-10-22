require 'rails_helper'

describe DepartmentManager do
  let(:klass) { described_class }

  describe "relationships" do
    it "belongs to Employee" do
      expect(klass.reflect_on_association(:employee).macro).to eq(:belongs_to)
    end

    it "belongs to Department" do
      expect(klass.reflect_on_association(:department).macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    context "when Employee or Department does not exist" do
      it "is invalid" do
        department_manager = FactoryGirl.build(:department_manager)
        expect(department_manager.valid?).to be false
      end
    end

    context "when Employee and Department exist" do
      let(:emp_no) { 1 }
      let(:dept_no) { "d002" }
      let(:params) { { emp_no: emp_no, dept_no: dept_no } }

      before do
        FactoryGirl.create(:employee, emp_no: emp_no)
        FactoryGirl.create(:department, dept_no: dept_no)
      end

      context "with all correct parameters" do
        it "is valid" do
          department_manager = FactoryGirl.build(:department_manager, params)
          expect(department_manager.valid?).to be true
        end
      end

      context "with missing emp no" do
        it "is invalid" do
          params.merge!(emp_no: nil)
          department_manager = FactoryGirl.build(:department_manager, params)
          expect(department_manager.valid?).to be false
        end
      end

      context "with missing dept no" do
        it "is invalid" do
          params.merge!(dept_no: nil)
          department_manager = FactoryGirl.build(:department_manager, params)
          expect(department_manager.valid?).to be false
        end
      end

      context "with missing 'from date'" do
        it "is invalid" do
          params.merge!(from_date: nil)
          department_manager = FactoryGirl.build(:department_manager, params)
          expect(department_manager.valid?).to be false
        end
      end

      context "with missing 'to date'" do
        it "is invalid" do
          params.merge!(to_date: nil)
          department_manager = FactoryGirl.build(:department_manager, params)
          expect(department_manager.valid?).to be false
        end
      end
    end
  end
end
