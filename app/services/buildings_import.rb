class BuildingsImport < ImportExecution
  private

  def primary_attributes
    %[manager_name]
  end

  def target_model
    Building
  end
end
