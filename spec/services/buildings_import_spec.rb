require "rails_helper"

RSpec.describe BuildingsImport do
  subject(:buildings_import_execution) { described_class.new(csv_file: csv_file) }
  let(:csv_file) { file_fixture('buildings.csv') }

  it { expect(described_class).to be < ImportExecution }

  describe "#primary_attributes" do
    it "returns the specific fields to consider unique" do
      expect(buildings_import_execution.primary_attributes)
        .to eq("manager_name")
    end
  end

  describe "#target_model" do
    it "returns the ActiveRecord model to import" do
      expect(buildings_import_execution.target_model)
        .to eq(Building)
    end
  end

  describe "Importing CSV rows :" do
    context "when each rows have the same address but a unique manager_name" do
    end

    context "when each rows have the same address and manager_name" do
    end
  end
end
