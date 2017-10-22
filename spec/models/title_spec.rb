require 'rails_helper'

describe Title do
  let(:klass) { described_class }

  describe "relationships" do
    it "belongs to Employee" do
      expect(klass.reflect_on_association(:employee).macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    context "when Employee does not exist" do
      it "is invalid" do
        title = FactoryGirl.build(:title)
        expect(title.valid?).to be false
      end
    end

    context "when Employee exists" do
      let(:emp_no) { 1 }
      let(:params) { { emp_no: emp_no } }

      before do
        FactoryGirl.create(:employee, emp_no: emp_no)
      end

      context "with all correct parameters" do
        it "is valid" do
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be true
        end
      end

      context "with missing emp no" do
        it "is invalid" do
          params.merge!(emp_no: nil)
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be false
        end
      end

      context "with missing title" do
        it "is invalid" do
          params.merge!(title: nil)
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be false
        end
      end

      context "with too long title" do
        it "is invalid" do
          new_title = "X"*100
          params.merge!(title: new_title)
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be false
        end
      end

      context "with missing 'from date'" do
        it "is invalid" do
          params.merge!(from_date: nil)
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be false
        end
      end

      context "with missing 'to date'" do
        it "is invalid" do
          params.merge!(to_date: nil)
          title = FactoryGirl.build(:title, params)
          expect(title.valid?).to be false
        end
      end
    end
  end
end
