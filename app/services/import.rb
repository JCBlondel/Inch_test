class Import
  attr_reader :errors
  attr_reader :file

  def initialize(file:)
    @errors = []
    @file = file
  end

  def perform
    case File.open(file, &:readline).strip.split(',').sort
    when %w[reference address zip_code city country manager_name].sort
      BuildingsImport.new(csv_file: file).perform
    when %w[reference firstname lastname home_phone_number mobile_phone_number email address].sort
      PeopleImport.new(csv_file: file).perform
    else
      errors << ['Wrong header']
    end
    self
  end
end
