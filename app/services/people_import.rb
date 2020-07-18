class PeopleImport < ImportExecution
  private

  def primary_attributes
    %w[email home_phone_number mobile_phone_number address]
  end

  def target_model
    Person
  end
end
