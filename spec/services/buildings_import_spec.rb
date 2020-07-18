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
    before do
      buildings_import_execution.perform
    end

    context "when each rows have the same address but a unique manager_name" do
      let(:csv_file) { file_fixture('buildings_same_address_unique_manager_name.csv') }

      it "creates two buildings" do
        expect(Building.count).to eq(2)
      end
    end

    context "when each rows have the same address and manager_name" do
      let(:csv_file) { file_fixture('buildings_same_address_and_manager_name.csv') }

      it "creates two buildings" do
        expect(Building.count).to eq(2)
      end

      it "leaves the last building without manager name" do
        expect(Building.last.manager_name).to be_nil
      end
    end
  end

  describe "Updating a building instance manually :" do
    before do
      buildings_import_execution.perform
    end

    let(:csv_file) { file_fixture('buildings.csv') }

    it "it is possible to manually update a building with the same values from another, keeping its reference unique" do
      expect(Building.first.update(Building.last.attributes.except("id", "reference")))
        .to be true
    end
  end
end
