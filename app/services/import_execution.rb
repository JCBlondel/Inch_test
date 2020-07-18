require 'csv'

class ImportExecution
  attr_reader :items
  attr_reader :csv_file
  attr_reader :primary_attributes
  attr_reader :target_model

  def initialize(csv_file:)
    @csv_file = csv_file
    @items = []
    @primary_attributes = set_primary_attributes
    @target_model = set_target_model
  end

  def perform
    read_csv_as_items
    start_import
  end

  private

  def read_csv_as_items
    CSV.foreach(csv_file, headers: true) do |row|
      items << row.to_h
    end
  end

  def set_primary_attributes
    nil
  end

  def set_target_model
    nil
  end

  def start_import
    all_instances = []
    items.each do |item|
      instance_attributes = {}
      item.each do |key, value|
        if primary_attributes.include?(key)
          instance_attributes.merge!(key => value) unless all_instances.find { |instance| instance[key] == value }
        else
          instance_attributes.merge!(key => value)
        end
      end
      target_model.upsert(instance_attributes.merge!(created_at: Time.now, updated_at: Time.now),
                          unique_by: :reference)
      all_instances << instance_attributes
    end
  end
end
