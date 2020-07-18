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
    check_header
    start_import unless errors.any?
    self
  end

  protected

  def check_header
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

  def read_csv_as_items
    items = []
    CSV.foreach(file, headers: true) do |row|
      items << row.to_h
    end
    items
  end

  def start_import
    items = read_csv_as_items
    target_model.upsert_all(items.map { |attributes|
      attributes.merge!(created_at: Time.now, updated_at: Time.now)
    }, unique_by: %i[reference])
  end
end
