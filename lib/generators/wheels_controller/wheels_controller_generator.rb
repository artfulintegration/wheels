class WheelsControllerGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs a copy of the named controller into the app/controllers folder."

  def install_file
    if class_name == "All"
      directory "app/controllers", "app/controllers"
    else
      file "app/controllers/#{plural_name}_controller.rb", "app/controllers/#{plural_name}_controller.rb"
    end
  end
end

