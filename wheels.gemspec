# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wheels}
  s.version = "0.1.25"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Gannon"]
  s.date = %q{2010-10-04}
  s.description = %q{Call rails generate wheels.}
  s.email = %q{tgannon@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/access_control_entries_controller.rb",
     "app/controllers/app_configs_controller.rb",
     "app/controllers/application_controller.rb",
     "app/controllers/attachments_controller.rb",
     "app/controllers/blogs_controller.rb",
     "app/controllers/discussions_controller.rb",
     "app/controllers/external_links_controller.rb",
     "app/controllers/feedbacks_controller.rb",
     "app/controllers/forum_messages_controller.rb",
     "app/controllers/forums_controller.rb",
     "app/controllers/galleries_controller.rb",
     "app/controllers/images_controller.rb",
     "app/controllers/menus_controller.rb",
     "app/controllers/pages_controller.rb",
     "app/controllers/profiles_controller.rb",
     "app/controllers/sitemaps_controller.rb",
     "app/controllers/users_controller.rb",
     "app/helpers/access_control_entries_helper.rb",
     "app/helpers/app_configs_helper.rb",
     "app/helpers/application_helper.rb",
     "app/helpers/blogs_helper.rb",
     "app/helpers/discussions_helper.rb",
     "app/helpers/external_links_helper.rb",
     "app/helpers/feedbacks_helper.rb",
     "app/helpers/forums_helper.rb",
     "app/helpers/menus_helper.rb",
     "app/helpers/pages_helper.rb",
     "app/helpers/sitemaps_helper.rb",
     "app/mailers/feedback_mailer.rb",
     "app/models/ability.rb",
     "app/models/access_control_entry.rb",
     "app/models/app_config.rb",
     "app/models/attachment.rb",
     "app/models/blog.rb",
     "app/models/discussion.rb",
     "app/models/external_link.rb",
     "app/models/feedback.rb",
     "app/models/forum.rb",
     "app/models/forum_message.rb",
     "app/models/gallery.rb",
     "app/models/image.rb",
     "app/models/menu.rb",
     "app/models/page.rb",
     "app/models/page_revision.rb",
     "app/models/profile.rb",
     "app/models/role.rb",
     "app/models/s3_provider.rb",
     "app/models/sitemap.rb",
     "app/models/tagging.rb",
     "app/models/user.rb",
     "app/validators/email_validator.rb",
     "app/views/access_control_entries/_form.html.haml",
     "app/views/access_control_entries/_index.html.haml",
     "app/views/access_control_entries/_show.html.haml",
     "app/views/access_control_entries/create.js.haml",
     "app/views/access_control_entries/destroy.js.haml",
     "app/views/access_control_entries/edit.html.haml",
     "app/views/access_control_entries/edit.js.haml",
     "app/views/access_control_entries/index.html.haml",
     "app/views/access_control_entries/index.js.haml",
     "app/views/access_control_entries/new.html.haml",
     "app/views/access_control_entries/new.js.haml",
     "app/views/access_control_entries/show.html.haml",
     "app/views/access_control_entries/show.js.haml",
     "app/views/access_control_entries/update.js.haml",
     "app/views/app_configs/_form.html.haml",
     "app/views/app_configs/_index.html.haml",
     "app/views/app_configs/_show.html.haml",
     "app/views/app_configs/create.js.haml",
     "app/views/app_configs/css.css.haml",
     "app/views/app_configs/destroy.js.haml",
     "app/views/app_configs/edit.html.haml",
     "app/views/app_configs/edit.js.haml",
     "app/views/app_configs/index.html.haml",
     "app/views/app_configs/index.js.haml",
     "app/views/app_configs/new.html.haml",
     "app/views/app_configs/new.js.haml",
     "app/views/app_configs/show.html.haml",
     "app/views/app_configs/show.js.haml",
     "app/views/app_configs/update.js.haml",
     "app/views/attachments/_form.html.haml",
     "app/views/attachments/_index.html.haml",
     "app/views/attachments/_show.html.haml",
     "app/views/attachments/_uploadify.html.erb",
     "app/views/attachments/create.js.haml",
     "app/views/attachments/destroy.js.haml",
     "app/views/attachments/edit.js.haml",
     "app/views/attachments/index.html.haml",
     "app/views/attachments/index.js.haml",
     "app/views/attachments/new.html.haml",
     "app/views/attachments/new.js.haml",
     "app/views/attachments/show.html.haml",
     "app/views/attachments/show.js.haml",
     "app/views/attachments/update.js.haml",
     "app/views/blogs/_form.html.haml",
     "app/views/blogs/edit.html.haml",
     "app/views/blogs/index.html.haml",
     "app/views/blogs/index.xml.builder",
     "app/views/blogs/new.html.haml",
     "app/views/blogs/show.html.haml",
     "app/views/discussions/_form.html.haml",
     "app/views/discussions/edit.html.haml",
     "app/views/discussions/index.html.haml",
     "app/views/discussions/new.html.haml",
     "app/views/discussions/show.html.haml",
     "app/views/external_links/_fields_for.html.haml",
     "app/views/external_links/_form.html.haml",
     "app/views/external_links/_show.html.haml",
     "app/views/external_links/create.js.haml",
     "app/views/external_links/destroy.js.haml",
     "app/views/external_links/edit.html.haml",
     "app/views/external_links/edit.js.haml",
     "app/views/external_links/index.html.haml",
     "app/views/external_links/index.js.haml",
     "app/views/external_links/new.html.haml",
     "app/views/external_links/new.js.haml",
     "app/views/external_links/show.html.haml",
     "app/views/external_links/show.js.haml",
     "app/views/external_links/update.js.haml",
     "app/views/feedback_mailer/submit_feedback.html.haml",
     "app/views/feedbacks/_form.html.haml",
     "app/views/feedbacks/index.html.haml",
     "app/views/feedbacks/new.html.haml",
     "app/views/feedbacks/show.html.haml",
     "app/views/forum_messages/_form.html.haml",
     "app/views/forum_messages/index.html.haml",
     "app/views/forum_messages/new.html.haml",
     "app/views/forums/_form.html.haml",
     "app/views/forums/edit.html.haml",
     "app/views/forums/index.html.haml",
     "app/views/forums/new.html.haml",
     "app/views/forums/show.html.haml",
     "app/views/galleries/_form.html.haml",
     "app/views/galleries/_show.html.haml",
     "app/views/galleries/edit.html.haml",
     "app/views/galleries/index.html.haml",
     "app/views/galleries/new.html.haml",
     "app/views/galleries/show.html.haml",
     "app/views/images/_form.html.haml",
     "app/views/images/create.js.haml",
     "app/views/images/destroy.js.haml",
     "app/views/images/edit.html.haml",
     "app/views/images/edit.js.haml",
     "app/views/images/index.html.haml",
     "app/views/images/index.js.haml",
     "app/views/images/new.html.haml",
     "app/views/images/new.js.haml",
     "app/views/images/show.html.haml",
     "app/views/images/show.js.haml",
     "app/views/images/update.js.haml",
     "app/views/layouts/application.html.haml",
     "app/views/layouts/bare.html.haml",
     "app/views/layouts/image_dialog.html.haml",
     "app/views/loadbehind/_destroy.js.haml",
     "app/views/loadbehind/_edit.js.haml",
     "app/views/loadbehind/_errors.html.haml",
     "app/views/loadbehind/_growl_template.html.haml",
     "app/views/loadbehind/_show_box.html.haml",
     "app/views/loadbehind/_view.js.haml",
     "app/views/loadbehind/growl.js.haml",
     "app/views/loadbehind/index.js.haml",
     "app/views/menus/_form.html.haml",
     "app/views/menus/edit.html.haml",
     "app/views/menus/index.html.haml",
     "app/views/menus/new.html.haml",
     "app/views/menus/show.html.haml",
     "app/views/pages/_child_pages_links.html.haml",
     "app/views/pages/_control_panel.html.haml",
     "app/views/pages/_form.html.haml",
     "app/views/pages/_form_fields.html.haml",
     "app/views/pages/_show.html.haml",
     "app/views/pages/_show_attachment.html.haml",
     "app/views/pages/_show_small.html.haml",
     "app/views/pages/create.js.haml",
     "app/views/pages/destroy.js.haml",
     "app/views/pages/edit.html.haml",
     "app/views/pages/edit.js.haml",
     "app/views/pages/index.html.haml",
     "app/views/pages/index.js.haml",
     "app/views/pages/new.html.haml",
     "app/views/pages/new.js.haml",
     "app/views/pages/show.html.haml",
     "app/views/pages/show.js.haml",
     "app/views/pages/update.js.haml",
     "app/views/profiles/_form.html.haml",
     "app/views/profiles/edit.html.haml",
     "app/views/profiles/index.html.haml",
     "app/views/profiles/new.html.haml",
     "app/views/profiles/show.html.haml",
     "app/views/sitemaps/edit.html.haml",
     "app/views/sitemaps/edit.js.erb",
     "app/views/sitemaps/index.html.haml",
     "app/views/sitemaps/index.json.erb",
     "app/views/sitemaps/new.html.haml",
     "app/views/sitemaps/new.js.erb",
     "app/views/users/change_password.html.haml",
     "app/views/users/edit.html.haml",
     "app/views/users/index.html.haml",
     "config/amazon_s3.yml",
     "db/migrate/0000_devise_create_users.rb",
     "db/migrate/0010_add_fields_to_users.rb",
     "db/migrate/0020_create_blogs.rb",
     "db/migrate/0030_create_galleries.rb",
     "db/migrate/0040_create_images.rb",
     "db/migrate/0050_create_profiles.rb",
     "db/migrate/0060_insert_admin_user_and_roles.rb",
     "db/migrate/0070_create_pages.rb",
     "db/migrate/0080_create_forums.rb",
     "db/migrate/0090_create_discussions.rb",
     "db/migrate/0100_create_forum_messages.rb",
     "db/migrate/0110_create_access_control_entries.rb",
     "db/migrate/0120_create_attachments.rb",
     "db/migrate/0130_create_roles.rb",
     "db/migrate/0140_create_feedbacks.rb",
     "db/migrate/0150_create_external_links.rb",
     "db/migrate/0160_create_sitemaps.rb",
     "db/migrate/0170_create_menus.rb",
     "db/migrate/0180_acts_as_taggable_on_migration.rb",
     "db/migrate/20100912194121_add_stylesheet_to_pages.rb",
     "db/migrate/20100913073354_add_position_to_access_control_entries.rb",
     "init.rb",
     "lib/development_mail_interceptor.rb",
     "lib/generators/app_layout/LICENCE",
     "lib/generators/app_layout/USAGE",
     "lib/generators/app_layout/app_layout_generator.rb",
     "lib/generators/core_extensions.rb",
     "lib/generators/recipes/cancan.rb",
     "lib/generators/recipes/cucumber.rb",
     "lib/generators/recipes/default.rb",
     "lib/generators/recipes/design.rb",
     "lib/generators/recipes/devise.rb",
     "lib/generators/recipes/factory_girl.rb",
     "lib/generators/recipes/haml.rb",
     "lib/generators/recipes/jquery.rb",
     "lib/generators/recipes/mongoid.rb",
     "lib/generators/recipes/postgresql.rb",
     "lib/generators/recipes/recipes.rb",
     "lib/generators/recipes/remarkable.rb",
     "lib/generators/recipes/rspec.rb",
     "lib/generators/recipes/wheels.rb",
     "lib/generators/recipes/wheels_update.rb",
     "lib/generators/snippets/cucumber/database_config",
     "lib/generators/templates/cancan/ability.rb",
     "lib/generators/templates/database/postgresql.yml",
     "lib/generators/templates/git/gitignore",
     "lib/generators/templates/haml/app/views/layouts/application.html.haml",
     "lib/generators/templates/mongoid/features/step_definitions/mongoid_steps.rb",
     "lib/generators/templates/mongoid/features/support/hooks.rb",
     "lib/generators/wheels/LICENCE",
     "lib/generators/wheels/USAGE",
     "lib/generators/wheels/templater.rb",
     "lib/generators/wheels/wheels_generator.rb",
     "lib/generators/wheels_checkout_assets/USAGE",
     "lib/generators/wheels_checkout_assets/wheels_checkout_assets_generator.rb",
     "lib/generators/wheels_checkout_assets_readonly/USAGE",
     "lib/generators/wheels_checkout_assets_readonly/wheels_checkout_assets_readonly_generator.rb",
     "lib/generators/wheels_controller/USAGE",
     "lib/generators/wheels_controller/wheels_controller_generator.rb",
     "lib/generators/wheels_model/USAGE",
     "lib/generators/wheels_model/wheels_model_generator.rb",
     "lib/generators/wheels_update/LICENCE",
     "lib/generators/wheels_update/USAGE",
     "lib/generators/wheels_update/wheels_update_generator.rb",
     "lib/generators/wheels_view/USAGE",
     "lib/generators/wheels_view/wheels_view_generator.rb",
     "lib/wheels.rb",
     "lib/wheels/action_controller_extensions.rb",
     "lib/wheels/action_view_helper_extensions.rb",
     "lib/wheels/active_record_extensions.rb",
     "lib/wheels/active_record_user_extensions.rb",
     "lib/wheels/flash_session_cookie_middleware.rb",
     "lib/wheels/html_writer.rb",
     "lib/wheels/paperclip_interpolations.rb",
     "lib/wheels/password_validators.rb",
     "lib/wheels/routes.rb",
     "lib/wheels/s3login_provider.rb",
     "lib/wheels/user.rb",
     "lib/wheels/wheels_engine.rb",
     "wheels.gemspec"
  ]
  s.homepage = %q{http://github.com/tylergannon/wheels}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Generator builds a web site with blog, user profile, etc.}
  s.test_files = [
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

