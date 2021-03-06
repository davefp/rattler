require 'rattler/compiler/optimizer'

module Rattler::Compiler::Optimizer

  # A choice of Regexp matches can be joined into a single Regexp match without
  # affecting how it parses.
  class JoinMatchChoice < Optimization
    include MatchJoining

    include Rattler::Parsers

    protected

    def _applies_to?(parser, context)
      parser.is_a?(Choice) and
      super
    end

    def join_patterns(patterns)
      patterns.join '|'
    end

    def eligible_child?(child)
      child.is_a? Match
    end

  end
end
