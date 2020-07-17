class PagesController < ApplicationController
  def home
  end

  def import
    #file = File.read(params[:file_to_import].path, mode: 'r:bom|utf-8')
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
