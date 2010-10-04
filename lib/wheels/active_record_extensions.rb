module Wheels
  module ActiveRecordExtensions
    def form_attributes(attrib={}, options={})
      @form_attributes = attrib
      class_eval do
        def form_fields
          self.class.instance_variable_get('@form_attributes')
        end
      end
    end
  end
end
ActiveRecord::Base.extend Wheels::ActiveRecordExtensions

