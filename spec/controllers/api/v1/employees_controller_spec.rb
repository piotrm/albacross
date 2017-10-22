require 'rails_helper'

describe Api::V1::EmployeesController do
  describe "GET index" do
    let(:employees_count) { 2 }

    context "when some employees are returned" do
      before do
        employees_count.times do
          build_employee_with_relations
        end
        allow(FetchEmployees).to receive(:call).and_return(Employee.all)
      end

      it "returns 200 and collection" do
        get :index

        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_response["items"].count).to eq(employees_count)
        expect(parsed_response["metadata"]["count"]).to eq(employees_count)
        parsed_response["items"].each do |item|
          expect(item["metadata"]["type"]).to eq("employee")
        end
      end
    end

    context "when no employees are returned" do
      before do
        allow(FetchEmployees).to receive(:call).and_return([])
      end

      it "returns 200 and empty collection" do
        get :index

        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_response["items"].count).to eq(0)
        expect(parsed_response["metadata"]["count"]).to eq(0)
      end
    end

    context "when incorrect format of params is provided" do
      it "returns 400" do
        get :index, params: { page: "a", per_page: "bcd" }

        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(parsed_response["message"]).to eq("Incorrect parameters")
      end
    end
  end
end
