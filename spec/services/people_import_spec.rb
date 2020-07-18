require "rails_helper"

RSpec.describe PeopleImport do
  subject(:people_import_execution) { described_class.new(csv_file: csv_file) }
  let(:csv_file) { file_fixture('people.csv') }

  it { expect(described_class).to be < ImportExecution }

  describe "#primary_attributes" do
    it "returns the specific fields to consider unique" do
      expect(people_import_execution.primary_attributes)
        .to eq(%w[email home_phone_number mobile_phone_number address])
    end
  end

  describe "#target_model" do
    it "returns the ActiveRecord model to import" do
      expect(people_import_execution.target_model)
        .to eq(Person)
    end
  end

  describe "Importing CSV rows :" do
    context "when each rows have the same firstname but a unique email" do
    end

    context "when each rows have the same firstname and email" do
    end
  end
end
