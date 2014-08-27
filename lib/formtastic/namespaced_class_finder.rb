require 'formtastic/basic_class_finder'

module Formtastic
  # This class implements class resolution in a namespace chain. It
  # is used both by InputHelper and ActionHelper to look up custom
  # action and input classes.
  #
  # See
  #   +Formtastic::Helpers::InputHelper+
  #   +Formtastic::Helpers::ActionHelper+
  # for details.
  #
  class NamespacedClassFinder < BasicClassFinder
    attr_reader :namespaces #:nodoc:

    # @private
    class NotFoundError < NameError
    end

    def initialize(namespaces) #:nodoc:
      @namespaces = Array(namespaces).flatten
      super()
    end

    def resolve(as)
      class_name = class_name(as)

      finder(class_name) or raise NotFoundError, "class #{class_name}"
    end

    private

    def class_name(as)
      as.to_s.camelize
    end

    # Looks up the given class name in the configured namespaces in order,
    # returning the first one that has the class name constant defined.
    def find_with_const_defined(class_name)
      @namespaces.find do |namespace|
        if namespace.const_defined?(class_name)
          break namespace.const_get(class_name)
        end
      end
    end

    # Use auto-loading in development environment
    def find_by_trying(class_name)
      @namespaces.find do |namespace|
        begin
          break namespace.const_get(class_name)
        rescue NameError
        end
      end
    end
  end
end
