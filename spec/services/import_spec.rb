require "rails_helper"

RSpec.describe Import do
  subject(:import) { described_class.new(file: csv_file) }
  let(:csv_file) { file_fixture('people.csv') }

  describe "Attributes:" do
    it { is_expected.to(have_attr_accessor(:errors)) }
    it { is_expected.to(have_attr_reader(:csv)) }
    it { is_expected.to(have_attr_reader(:file)) }
    it { is_expected.to(have_attr_reader(:target_model)) }
  end
end
