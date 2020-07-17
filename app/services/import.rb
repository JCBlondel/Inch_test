class Import
  attr_accessor :errors
  attr_reader :file

  def initialize(file:)
    @errors = []
    @file = file
  end

  def perform
    self
  end
end
