module Filter
  class After < Base
    private

    def apply
      @query = filter.reduce(query) { |q, (column, value)| q.where(::Sequel.lit("#{column} > ?", value) ) }
    end
  end
end
