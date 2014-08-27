require 'formtastic/basic_class_finder'

module Formtastic
  class DeprecatedInputClassFinder < BasicClassFinder
    ::ActiveSupport::Deprecation.warn("Using DeprecatedInputClassFinder is deprecated in favour of :input_namespaces option and will be removed in the next version")

    def initialize(builder)
      @builder = builder
      super()
    end

    private

    def find_with_const_defined(as)
      @builder.send(:input_class_with_const_defined, as)
    end

    def find_by_trying(as)
      @builder.send(:input_class_by_trying, as)
    end
  end
end
