require 'csv'

class Import
  attr_reader :errors
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
    people_attributes = []
    items.each do |person|
      person_attributes = {}
      person.each do |key, value|
        if %w[email home_phone_number mobile_phone_number address].include?(key)
          person_attributes.merge!(key => value) unless people_attributes.find { |person| person[key] == value }
        else
          person_attributes.merge!(key => value)
        end
      end
      target_model.upsert(person_attributes.merge!(created_at: Time.now, updated_at: Time.now),
                          unique_by: :reference)
      people_attributes << person_attributes
    end
  end
end
