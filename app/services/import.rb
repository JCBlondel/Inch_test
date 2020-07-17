require 'csv'

class Import
  attr_accessor :errors
  attr_reader :csv
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
    @csv = CSV.parse(file, headers: true)
    @target_model = case csv.headers
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
    csv.each do |row|
      target_model.create_or_find_by(row.to_h)
    end
  end
end
