require 'rattler/back_end/parser_generator'

module Rattler::BackEnd::ParserGenerator

  # @private
  class ListGenerator < DelegatingGenerator #:nodoc:
    include NestedSubGenerating

    protected

    def impl(list, init_args)
      generator = default_impl(list, init_args)
      specialize_for list, generator
      generator
    end

    def specialize_for(list, generator)
      case list.lower_bound
      when 0 then generator.extend List0Generating
      when 1 then generator.extend List1Generating
      end
    end
  end

  # @private
  class NestedListGenerator < ListGenerator #:nodoc:
    include Nested

    def default_impl(list, init_args)
      GeneralListGenerator.nested(*init_args)
    end
  end

  def ListGenerator.nested(*args)
    NestedListGenerator.new(*args)
  end

  # @private
  class TopLevelListGenerator < ListGenerator #:nodoc:
    include TopLevel

    def default_impl(list, init_args)
      GeneralListGenerator.top_level(*init_args)
    end
  end

  def ListGenerator.top_level(*args)
    TopLevelListGenerator.new(*args)
  end

end
