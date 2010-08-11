module ActionControllerExtensions
  def self.authorized
    class_eval do
      def resource
        authorize_this
        super
      end
    end
  end

  def authorize_this
    authorize! resource, params[:action] unless @authorized
    @authorized = true
  end
end

ActionController::Base.send :include, ActionControllerExtensions

