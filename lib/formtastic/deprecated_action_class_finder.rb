require 'formtastic/basic_class_finder'

module Formtastic
  class DeprecatedActionClassFinder < BasicClassFinder
    def initialize(builder)
      @builder = builder
      super()
    end

    private

    def finder(as)
      begin
        begin
          @builder.send(:custom_action_class_name, as).constantize
        rescue NameError
          @builder.send(:standard_action_class_name, as).constantize
        end
      rescue NameError
        raise Formtastic::UnknownActionError
      end
    end
  end
end
