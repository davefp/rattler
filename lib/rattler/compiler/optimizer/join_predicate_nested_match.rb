require 'rattler/compiler/optimizer'

module Rattler::Compiler::Optimizer

  # A predicate and an adjacent skip of a Regexp match in a Sequence can be
  # joined into a single skip of a Regexp match.
  class JoinPredicateNestedMatch < JoinPredicateBareMatch
    include CompositeReducing

    include Rattler::Parsers

    protected

    def reduce(*pair)
      pair.find {|_| _.is_a? Skip }.with_child super
    end

    def prepare_pattern(parser)
      super(parser.is_a?(Skip) ? parser.child : parser)
    end

    def eligible_match?(parser)
      parser.is_a? Skip and
      super parser.child
    end

  end
end
