class BuildingsImport < ImportExecution
  private

  def set_primary_attributes
    %[manager_name]
  end

  def set_target_model
    Building
  end
end
