class ExternalLinksController < InheritedResources::Base
  respond_to :html, :js
  ajax_loading
end

