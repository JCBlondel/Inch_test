require "rails_helper"

RSpec.describe Import do
  subject(:import) { described_class.new }

  describe "Attributes:" do
    it { is_expected.to(have_attr_reader(:file)) }
  end
end
