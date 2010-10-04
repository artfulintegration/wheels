class AppConfigsController < InheritedResources::Base
  respond_to :html, :js
  respond_to :css, :only=>:css
  ajax_loading

  def css
    @stylesheet = AppConfig["stylesheet"]
    if params[:page_id]
      page = Page.find(params[:page_id])
      @stylesheet += '\n/*  Page-level styles' + page.stylesheet
    end
    respond_with @stylesheet do |format|
      format.css{render :layout=>'bare'}
    end
  end
end

