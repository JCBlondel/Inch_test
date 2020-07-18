class PeopleImport < ImportExecution
  private

  def set_primary_attributes
    %w[email home_phone_number mobile_phone_number address]
  end

  def set_target_model
    Person
  end
end
