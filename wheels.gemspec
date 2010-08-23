# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wheels}
  s.version = "0.0.39"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Gannon"]
  s.date = %q{2010-08-22}
  s.description = %q{Call rails generate wheels.}
  s.email = %q{tgannon@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/access_control_entries_controller.rb",
     "app/controllers/attachments_controller.rb",
     "app/controllers/blogs_controller.rb",
     "app/controllers/discussions_controller.rb",
     "app/controllers/forum_messages_controller.rb",
     "app/controllers/forums_controller.rb",
     "app/controllers/galleries_controller.rb",
     "app/controllers/images_controller.rb",
     "app/controllers/pages_controller.rb",
     "app/controllers/profiles_controller.rb",
     "app/controllers/users_controller.rb",
     "app/helpers/access_control_entries_helper.rb",
     "app/helpers/application_helper.rb",
     "app/helpers/blogs_helper.rb",
     "app/helpers/discussions_helper.rb",
     "app/helpers/forums_helper.rb",
     "app/helpers/pages_helper.rb",
     "app/models/ability.rb",
     "app/models/access_control_entry.rb",
     "app/models/attachment.rb",
     "app/models/blog.rb",
     "app/models/discussion.rb",
     "app/models/forum.rb",
     "app/models/forum_message.rb",
     "app/models/gallery.rb",
     "app/models/image.rb",
     "app/models/page.rb",
     "app/models/page_revision.rb",
     "app/models/profile.rb",
     "app/models/role.rb",
     "app/models/s3_provider.rb",
     "app/models/tagging.rb",
     "app/models/user.rb",
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
     "app/views/layouts/image_dialog.html.haml",
     "app/views/loadbehind/_destroy.js.haml",
     "app/views/loadbehind/_edit.js.haml",
     "app/views/loadbehind/_errors.html.haml",
     "app/views/loadbehind/_growl_template.html.haml",
     "app/views/loadbehind/_show_box.html.haml",
     "app/views/loadbehind/_view.js.haml",
     "app/views/loadbehind/growl.js.haml",
     "app/views/loadbehind/index.js.haml",
     "app/views/pages/_child_pages_links.html.haml",
     "app/views/pages/_control_panel.html.haml",
     "app/views/pages/_form.html.haml",
     "app/views/pages/_form_fields.html.haml",
     "app/views/pages/_show_attachment.html.haml",
     "app/views/pages/_show_small.html.haml",
     "app/views/pages/create.js.haml",
     "app/views/pages/edit.html.haml",
     "app/views/pages/index.html.haml",
     "app/views/pages/new.html.haml",
     "app/views/pages/show.html.haml",
     "app/views/pages/update.js.haml",
     "app/views/profiles/_form.html.haml",
     "app/views/profiles/edit.html.haml",
     "app/views/profiles/index.html.haml",
     "app/views/profiles/new.html.haml",
     "app/views/profiles/show.html.haml",
     "app/views/users/index.html.haml",
     "config/amazon_s3.yml",
     "db/migrate/add_fields_to_users.rb",
     "db/migrate/create_access_control_entries.rb",
     "db/migrate/create_attachments.rb",
     "db/migrate/create_blogs.rb",
     "db/migrate/create_discussions.rb",
     "db/migrate/create_forum_messages.rb",
     "db/migrate/create_forums.rb",
     "db/migrate/create_galleries.rb",
     "db/migrate/create_images.rb",
     "db/migrate/create_pages.rb",
     "db/migrate/create_profiles.rb",
     "db/migrate/create_roles.rb",
     "db/migrate/insert_admin_user_and_roles.rb",
     "init.rb",
     "lib/generators/app_layout/LICENCE",
     "lib/generators/app_layout/USAGE",
     "lib/generators/app_layout/app_layout_generator.rb",
     "lib/generators/app_layout/core_extensions.rb",
     "lib/generators/update_wheels/LICENCE",
     "lib/generators/update_wheels/USAGE",
     "lib/generators/update_wheels/core_extensions.rb",
     "lib/generators/update_wheels/recipes/wheels.rb",
     "lib/generators/update_wheels/templates/cancan/ability.rb",
     "lib/generators/update_wheels/templates/database/postgresql.yml",
     "lib/generators/update_wheels/templates/git/gitignore",
     "lib/generators/update_wheels/templates/haml/app/views/layouts/application.html.haml",
     "lib/generators/update_wheels/templates/mongoid/features/step_definitions/mongoid_steps.rb",
     "lib/generators/update_wheels/templates/mongoid/features/support/hooks.rb",
     "lib/generators/update_wheels/update_wheels_generator.rb",
     "lib/generators/wheels/LICENCE",
     "lib/generators/wheels/USAGE",
     "lib/generators/wheels/core_extensions.rb",
     "lib/generators/wheels/install_generator.rb",
     "lib/generators/wheels/recipes/cancan.rb",
     "lib/generators/wheels/recipes/cucumber.rb",
     "lib/generators/wheels/recipes/default.rb",
     "lib/generators/wheels/recipes/design.rb",
     "lib/generators/wheels/recipes/devise.rb",
     "lib/generators/wheels/recipes/factory_girl.rb",
     "lib/generators/wheels/recipes/haml.rb",
     "lib/generators/wheels/recipes/jquery.rb",
     "lib/generators/wheels/recipes/mongoid.rb",
     "lib/generators/wheels/recipes/postgresql.rb",
     "lib/generators/wheels/recipes/recipes.rb",
     "lib/generators/wheels/recipes/remarkable.rb",
     "lib/generators/wheels/recipes/rspec.rb",
     "lib/generators/wheels/recipes/wheels.rb",
     "lib/generators/wheels/snippets/cucumber/database_config",
     "lib/generators/wheels/templater.rb",
     "lib/generators/wheels/templates/cancan/ability.rb",
     "lib/generators/wheels/templates/database/postgresql.yml",
     "lib/generators/wheels/templates/git/gitignore",
     "lib/generators/wheels/templates/haml/app/views/layouts/application.html.haml",
     "lib/generators/wheels/templates/mongoid/features/step_definitions/mongoid_steps.rb",
     "lib/generators/wheels/templates/mongoid/features/support/hooks.rb",
     "lib/generators/wheels/views_generator.rb",
     "lib/generators/wheels/wheels_generator.rb",
     "lib/generators/wheels_views/LICENCE",
     "lib/generators/wheels_views/USAGE",
     "lib/generators/wheels_views/wheels_views_generator.rb",
     "lib/wheels.rb",
     "lib/wheels/action_controller_extensions.rb",
     "lib/wheels/action_view_helper_extensions.rb",
     "lib/wheels/active_record_extensions.rb",
     "lib/wheels/active_record_user_extensions.rb",
     "lib/wheels/flash_session_cookie_middleware.rb",
     "lib/wheels/paperclip_interpolations.rb",
     "lib/wheels/routes.rb",
     "lib/wheels/s3login_provider.rb",
     "lib/wheels/user.rb",
     "lib/wheels/wheels_engine.rb",
     "public/404.html",
     "public/422.html",
     "public/500.html",
     "public/favicon.ico",
     "public/images/dreamy/Thumbs.db",
     "public/images/dreamy/bg-ad-top.png",
     "public/images/dreamy/bg-body.png",
     "public/images/dreamy/bg-feed.gif",
     "public/images/dreamy/bg-footer.jpg",
     "public/images/dreamy/bg-header.jpg",
     "public/images/dreamy/bg-menu-hover.png",
     "public/images/dreamy/bg-menu.png",
     "public/images/dreamy/bg-sidebar-bottom.gif",
     "public/images/dreamy/button-feed.png",
     "public/images/dreamy/icon-comment.png",
     "public/images/growl/error.png",
     "public/images/growl/growl_bottom.png",
     "public/images/growl/growl_repeat.png",
     "public/images/growl/growl_top.png",
     "public/images/growl/info.png",
     "public/images/menu/item-pointer-mover.gif",
     "public/images/menu/item-pointer.gif",
     "public/images/menu/lava.gif",
     "public/images/menu/lava.png",
     "public/images/menu/main-bg.png",
     "public/images/menu/main-delimiter.png",
     "public/javascripts/galleries/configure_ckeditor.js",
     "public/javascripts/jqUrl.js",
     "public/javascripts/jquery.growl.js",
     "public/javascripts/loadbehind.js",
     "public/javascripts/menu.js",
     "public/stylesheets/dreamy.css",
     "public/stylesheets/menu.css",
     "public/stylesheets/sass/dreamy.sass",
     "public/stylesheets/sass/menu.sass",
     "public/stylesheets/sass/wheels.sass",
     "public/stylesheets/scaffold.css",
     "public/stylesheets/ui-lightness/images/ui-anim_basic_16x16.gif",
     "public/stylesheets/ui-lightness/images/ui-bg_diagonals-thick_18_b81900_40x40.png",
     "public/stylesheets/ui-lightness/images/ui-bg_diagonals-thick_20_666666_40x40.png",
     "public/stylesheets/ui-lightness/images/ui-bg_flat_10_000000_40x100.png",
     "public/stylesheets/ui-lightness/images/ui-bg_glass_100_f6f6f6_1x400.png",
     "public/stylesheets/ui-lightness/images/ui-bg_glass_100_fdf5ce_1x400.png",
     "public/stylesheets/ui-lightness/images/ui-bg_glass_65_ffffff_1x400.png",
     "public/stylesheets/ui-lightness/images/ui-bg_gloss-wave_35_f6a828_500x100.png",
     "public/stylesheets/ui-lightness/images/ui-bg_highlight-soft_100_eeeeee_1x100.png",
     "public/stylesheets/ui-lightness/images/ui-bg_highlight-soft_75_ffe45c_1x100.png",
     "public/stylesheets/ui-lightness/images/ui-icons_222222_256x240.png",
     "public/stylesheets/ui-lightness/images/ui-icons_228ef1_256x240.png",
     "public/stylesheets/ui-lightness/images/ui-icons_ef8c08_256x240.png",
     "public/stylesheets/ui-lightness/images/ui-icons_ffd27a_256x240.png",
     "public/stylesheets/ui-lightness/images/ui-icons_ffffff_256x240.png",
     "public/stylesheets/ui-lightness/jquery-ui-1.8.2.custom.css",
     "public/test.html",
     "wheels.gemspec"
  ]
  s.homepage = %q{http://github.com/tylergannon/wheels}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Generator builds a web site with blog, user profile, etc.}

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

