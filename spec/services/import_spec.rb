require "rails_helper"

RSpec.describe Import do
  subject(:import) { described_class.new(file: csv_file) }
  let(:csv_file) { file_fixture('people.csv') }

  describe "Attributes :" do
    it { is_expected.to(have_attr_reader(:errors)) }
    it { is_expected.to(have_attr_reader(:file)) }
  end

  describe "Reading CSV header :" do
    context "when it is well ordered and no column is missing" do
    end

    context "when it is well ordered but a column is missing" do
    end

    context "when this one is messy but all columns are here" do
    end

    context "when this one is messy and one column is missing" do
    end
  end

  describe "Importing CSV rows :" do
    context "when each rows has a unique reference" do
    end

    context "when 2 rows have the same reference" do
    end
  end
end
