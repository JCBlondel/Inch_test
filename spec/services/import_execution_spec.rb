require "rails_helper"

RSpec.describe ImportExecution do
  subject(:import_execution) { described_class.new(csv_file: csv_file) }
  let(:csv_file) { file_fixture('people.csv') }

  describe "Attributes :" do
    it { is_expected.to(have_attr_reader(:items)) }
    it { is_expected.to(have_attr_reader(:csv_file)) }
    it { is_expected.to(have_attr_reader(:primary_attributes)) }
    it { is_expected.to(have_attr_reader(:target_model)) }
  end

  describe "#primary_attributes" do
    it "returns nil" do
      expect(import_execution.primary_attributes).to be_nil
    end
  end

  describe "#target_model" do
    it "returns nil" do
      expect(import_execution.target_model).to be_nil
    end
  end
end
