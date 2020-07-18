class ChangeReferenceToUniqueIndexForPersonAndBuilding < ActiveRecord::Migration[6.0]
  def change
    add_index :people, :reference, unique: true
    add_index :buildings, :reference, unique: true
  end
end
