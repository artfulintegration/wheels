class WheelsViewGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs a copy of the named view into the app/views folder."

  def install_files
    if class_name == "All"
      directory "app/views", "app/views"
    else
      directory "app/views/#{plural_name}", "app/views/#{plural_name}"
    end
  end
end

