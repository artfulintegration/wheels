class WheelsCheckoutAssetsReadonlyGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def checkout_files
    run "rm -rf public"
    run "git clone git://github.com/tylergannon/wheels_assets.git public"
    run "rm -rf public/.git"
  end
end

