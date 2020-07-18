require 'csv'

class ImportExecution
  attr_reader :items
  attr_reader :csv_file

  def initialize(csv_file:)
    @csv_file = csv_file
    @items = []
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

  def primary_attributes
    raise "ImportExecution #primary_attributes called but unset !"
  end

  def target_model
    raise "ImportExecution #target_model called but unset !"
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
