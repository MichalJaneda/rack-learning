module Filter
  class Limit < Base
    include ::Dry::Logic

    DEFAULT = ::Value::Filter::Limit::DEFAULT
    MAX = ::Value::Filter::Limit::MAX

    LIMIT_RULE = -> do
      less_than_max = Rule::Predicate.new(Predicates[:lteq?]).curry(MAX)
      is_int = Rule::Predicate.new(Predicates[:int?])
      is_positive = Rule::Predicate.new(Predicates[:gt?]).curry(0)

      is_int & is_positive & less_than_max
    end

    private

    def apply
      correct_limit = LIMIT_RULE.().(filter.to_i).success? ? filter : DEFAULT
      @query = query.limit(correct_limit)
    end
  end
end
