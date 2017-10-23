require 'rails_helper'

describe FetchActiveEmployees do
  let(:params) { { dept_no: "d005" } }

  subject { FetchActiveEmployees.new(params) }

  describe ".call" do
    it "executes #call on a new instance of FetchActiveEmployees" do
      fetch_active_employees_instance = double(:fetch_active_employees_instance)
      allow(FetchActiveEmployees).to receive(:new).and_return(fetch_active_employees_instance)

      expect(fetch_active_employees_instance).to receive(:call)
      described_class.call(params)
    end
  end

  describe "#call" do
    context "when there are no active employees" do
      before do
        allow(SeekEmployeeStats).to receive(:call).and_return([])
      end

      it "returns an empty collection" do
        result = subject.call
        expect(result.size).to eq(0)
      end
    end

    context "when there are active employees" do
      let(:emp_nos) { (1..5).to_a }

      before do
        emp_nos.each do |emp_no|
          build_employee_with_relations(employee: { emp_no: emp_no })
        end

        stats = emp_nos.inject([]) do
          |arr, emp_no| arr << build_active_employee_stats(emp_no)
        end

        allow(SeekEmployeeStats).to receive(:call).and_return(stats)
      end

      context "and provided params contain pagination-related ones" do
        let(:page) { 2 }
        let(:per_page) { 3 }
        let(:params) { { page: page, per_page: per_page} }

        it "returns paginated collection with proper parameters" do
          result = subject.call
          expect(result).to respond_to(:current_page)
          expect(result.current_page).to eq(page)
          expect(result).to respond_to(:per_page)
          expect(result.per_page).to eq(per_page)
        end

        it "returns proper number of elements" do
          result = subject.call
          expect(result.size).to eq([per_page, emp_nos.count].min)
        end
      end

      context "and provided params does not contain pagination-related ones" do
        let(:page) { described_class::DEFAULT_PAGE }
        let(:per_page) { described_class::DEFAULT_PER_PAGE }
        let(:params) { {} }

        it "returns paginated collection with proper parameters" do
          result = subject.call
          expect(result).to respond_to(:current_page)
          expect(result.current_page).to eq(page)
          expect(result).to respond_to(:per_page)
          expect(result.per_page).to eq(per_page)
        end

        it "returns proper number of elements" do
          result = subject.call
          expect(result.size).to eq([per_page, emp_nos.count].min)
        end
      end
    end
  end
end
