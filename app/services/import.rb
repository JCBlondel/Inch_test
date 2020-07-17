require 'csv'

class Import
  attr_accessor :errors
  attr_reader :file
  attr_reader :target_model

  def initialize(file:)
    @errors = []
    @file = file
  end

  def perform
    header_checking
    starting_import unless errors.any?
    self
  end

  protected

  def header_checking
    @target_model = case File.open(file, &:readline).strip.split(',')
    when %w[reference address zip_code city country manager_name]
      Building
    when %w[reference firstname lastname home_phone_number mobile_phone_number email address]
      Person
    else
      errors << ['Wrong header']
      nil
    end
  end

  def starting_import
    csv = CSV.new(file, headers: true)
    while row = csv.shift
      create_entry(attributes: row.to_h)
    end
  end

  def create_entry(attributes:)
    target_model.create!(attributes)
  rescue ActiveRecord::RecordInvalid => e
    target_model.update(attributes)
  end
end
