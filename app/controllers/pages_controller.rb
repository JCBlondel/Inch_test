class PagesController < ApplicationController
  def home
  end

  def import
    import = Import.new(file: params[:file_to_import])
    import.perform
    if import.errors.empty?
      flash[:notice] = "Import is starting, watch your supposed email."
    else
      flash[:alert] = "Import failed because : #{import.errors}"
    end

    redirect_back(fallback_location: root_path)
  end
end
