class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  protect_from_forgery
  def include_jqueryui
    content_for :head do
      stylesheet_link_tag("ui-lightness/jquery-ui-1.8.4.custom")
      javascript_include_tag("jquery-ui")
    end
  end

  load_main_menu


  def self.resource_attributes(*parameters)
    for action in [:show, :new, :edit, :create]
      a = "def #{action};" + ([:new, :create].include?(action) ?
        "@#{resource_class.name.underscore} = resource_class.new;" : ""
      ) +
      parameters.map{|p|
          if p.class == Hash
            meth, prm = [p.to_a.flatten[0], p.to_a.flatten[1]]
          else
            meth, prm = [p, p]
          end
          meth = meth.to_s + "="

          if prm == :current_user
            val = "current_user"
          else
            val = "params[:#{prm}]"
          end
          "resource.send(\"#{meth}\", #{val})"
        }.join(";") +
        ";#{action}!;end;"
      class_eval a
      puts a
    end
  end
end

