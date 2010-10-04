class WheelsModelGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs a copy of the named model into the app/models folder."

  def install_file
    if class_name == "All"
      directory "app/models", "app/models"
    else
      file "app/models/#{class_name.underscore}.rb", "app/models/#{class_name.underscore}.rb"
    end
  end
end

