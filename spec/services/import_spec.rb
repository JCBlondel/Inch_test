require "rails_helper"

RSpec.describe Import do
  subject(:import) { described_class.new(file: csv_file) }
  let(:csv_file) { file_fixture('people.csv') }

  describe "Attributes :" do
    it { is_expected.to(have_attr_reader(:errors)) }
    it { is_expected.to(have_attr_reader(:file)) }
  end

  describe "Reading CSV header :" do
    before do
      import.perform
    end

    context "when it is well ordered and no column is missing" do
      let(:csv_file) { file_fixture('people_ordered_all_columns.csv') }

      it "has no error" do
        expect(import.errors).to be_empty
      end
    end

    context "when it is well ordered but a column is missing" do
      let(:csv_file) { file_fixture('people_ordered_missing_column.csv') }

      it "has no error" do
        expect(import.errors).not_to be_empty
      end
    end

    context "when this one is messy but all columns are here" do
      let(:csv_file) { file_fixture('people_messy_all_columns.csv') }

      it "has no error" do
        expect(import.errors).to be_empty
      end
    end

    context "when this one is messy and one column is missing" do
      let(:csv_file) { file_fixture('people_messy_missing_column.csv') }

      it "has no error" do
        expect(import.errors).not_to be_empty
      end
    end
  end

  describe "Importing CSV rows :" do
    before do
      import.perform
    end

    context "when each rows has a unique reference" do
      let(:csv_file) { file_fixture('people_unique_references.csv') }

      it "creates two people" do
        expect(Person.count).to eq(2)
      end
    end

    context "when 2 rows have the same reference" do
      let(:csv_file) { file_fixture('people_same_references.csv') }

      it "creates only one person" do
        expect(Person.count).to eq(1)
      end
    end
  end
end
