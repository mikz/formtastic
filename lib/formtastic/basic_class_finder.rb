
module Formtastic
  class BasicClassFinder
    def initialize
      @cache = {}
    end

    # Looks up the given reference in the configured namespaces.
    #
    # Two finder methods are provided, one for development tries to
    # reference the constant directly, triggering Rails' autoloading
    # const_missing machinery; the second one instead for production
    # checks with .const_defined before referencing the constant.
    #
    def find(as)
      @cache[as] ||= resolve(as)
    end

    def resolve(as)
      finder(as)
    end

    private

    def self.caching?
      defined?(Rails) && ::Rails.application && ::Rails.application.config.cache_classes
    end

    if caching?
      def finder(class_name) # :nodoc:
        find_with_const_defined(class_name)
      end
    else
      def finder(class_name) # :nodoc:
        find_by_trying(class_name)
      end
    end
  end
end
