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
    before do
      people_import_execution.perform
    end

    context "when each rows have the same firstname but a unique email" do
      let(:csv_file) { file_fixture('people_same_firstname_unique_email.csv') }

      it "creates two people" do
        expect(Person.count).to eq(2)
      end
    end

    context "when each rows have the same firstname and email" do
      let(:csv_file) { file_fixture('people_same_firstname_and_email.csv') }

      it "creates two people" do
        expect(Person.count).to eq(2)
      end

      it "leaves the last person without email" do
        expect(Person.last.email).to be_nil
      end
    end
  end

  describe "Updating a person instance manually :" do
    before do
      people_import_execution.perform
    end

    let(:csv_file) { file_fixture('people.csv') }

    it "it is possible to manually update a person with the same values from another, keeping its reference unique" do
      expect(Person.first.update(Person.last.attributes.except("id", "reference")))
        .to be true
    end
  end
end
