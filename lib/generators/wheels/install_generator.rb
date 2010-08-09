class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../', __FILE__)
  desc "Installs files needed for App Template gem."

#      argument :scope, :required => false, :default => nil,
#                       :desc => "The scope to copy views to"

#      class_option :template_engine, :type => :string, :aliases => "-t",
#                                     :desc => "Template engine for the views. Available options are 'erb' and 'haml'."

  def rule
    generate "devise:install"
    ["add_fields_to_users.rb",
      "create_blogs.rb",
      "create_galleries.rb",
      "create_images.rb",
      "create_profiles.rb",
      "create_roles.rb"
    ].each {|file|  migration_template File.expand(file, 'db/migrate'), "db/migrate/#{file.split('.').first}"}



  end
end

