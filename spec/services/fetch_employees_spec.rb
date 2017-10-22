require 'rails_helper'

describe FetchEmployees do
  subject { FetchEmployees.new(params) }

  describe ".call" do
    it "executes #call on a new instance of FetchEmployees" do
      fetch_employees_instance = double(:fetch_employees_instance)
      allow(FetchEmployees).to receive(:new).and_return(fetch_employees_instance)

      expect(fetch_employees_instance).to receive(:call)
      described_class.call
    end
  end

  describe "#call" do
    context "when provided params contain pagination-related ones" do
      let(:page) { 2 }
      let(:per_page) { 3 }
      let(:params) { { page: page, per_page: per_page} }

      before do
        10.times do
          build_employee_with_relations
        end
      end

      it "returns paginated collection with proper parameters" do
        result = subject.call
        expect(result).to respond_to(:current_page)
        expect(result.current_page).to eq(page)
        expect(result).to respond_to(:per_page)
        expect(result.per_page).to eq(per_page)
      end

      it "returns proper number of elements" do
        result = subject.call
        expect(result.size).to eq(per_page)
      end
    end

    context "when provided params does not contain pagination-related ones" do
      let(:page) { described_class::DEFAULT_PAGE }
      let(:per_page) { described_class::DEFAULT_PER_PAGE }
      let(:params) { {} }

      before do
        10.times do
          build_employee_with_relations
        end
      end

      it "returns paginated collection with proper parameters" do
        result = subject.call
        expect(result).to respond_to(:current_page)
        expect(result.current_page).to eq(page)
        expect(result).to respond_to(:per_page)
        expect(result.per_page).to eq(per_page)
      end

      it "returns proper number of elements" do
        result = subject.call
        expect(result.size).to eq(per_page)
      end
    end

    context "when params contain salary-related params" do
      let(:salary_from) { 3 }
      let(:salary_to) { 7 }
      let(:params) { { salary_from: salary_from, salary_to: salary_to} }

      before do
        (1..10).to_a.each do |salary_value|
          build_employee_with_relations( { salary: { salary: salary_value } } )
        end
      end

      it "returns proper number of elements" do
        result = subject.call
        expect(result.size).to eq(5)
      end
    end
  end
end
