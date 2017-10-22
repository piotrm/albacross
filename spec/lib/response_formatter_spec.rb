require 'rails_helper'

describe ResponseFormatter do
  let(:url) { "https://test.url.com/api/v1/employees" }

  subject { ResponseFormatter.new(url) }

  describe "#from_item" do
    let(:type) { "employee" }
    let(:data) { ActiveModelSerializers::SerializableResource.new(employee).serializable_hash }

    before do
      employee = build_employee_with_relations
      @result_from_item = subject.from_item(employee)
    end

    it "returns proper format for single item" do
      expect(@result_from_item.keys).to include(:data)
      expect(@result_from_item.keys).to include(:metadata)
    end

    it "returns proper metadata for single item" do
      expect(@result_from_item[:metadata][:type]).to eq(type)
    end

    it "returns proper data for single item" do
      expect(@result_from_item[:metadata][:type]).to eq(type)
    end
  end

  describe "#from_collection" do
    let!(:collection) { Employee.all }

    before do
      3.times do
        build_employee_with_relations
      end

      @result_from_collection = subject.from_collection(collection)
    end

    it "returns proper format for collection" do
      expect(@result_from_collection.keys).to include(:items)
      expect(@result_from_collection.keys).to include(:metadata)
    end

    it "returns proper format for each of the elements in collection" do
      @result_from_collection[:items].each do |item|
        employee = Employee.where(emp_no: item[:data][:emp_no]).last
        expect(item).to eq(subject.from_item(employee))
      end
    end

    it "contains link pointing at 'self' in metadata" do
      expect(@result_from_collection[:metadata]).to include(:links)
      expect(@result_from_collection[:metadata][:links][:self]).to eq(url)
    end

    it "contains collection's count in metadata" do
      expect(@result_from_collection[:metadata]).to include(:count)
      expect(@result_from_collection[:metadata][:count]).to eq(collection.count)
    end

    it "contains 'collection' type in metadata" do
      expect(@result_from_collection[:metadata]).to include(:type)
      expect(@result_from_collection[:metadata][:type]).to eq("collection")
    end

    context "when collection is paginated" do
      let!(:collection) { Employee.all.paginate(page: 1, per_page: 1) }
      let(:url) { "https://test.url.com/api/v1/employees?page=1&per_page=1" }

      it "contains link with pagination params in metadata" do
        expect(@result_from_collection[:metadata]).to include(:links)
        expect(@result_from_collection[:metadata][:links][:self]).to eq(url)     
      end
    end
  end
end
