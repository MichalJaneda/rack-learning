module Filter
  class After < Base
    private

    def apply
      @query = filter.reduce(query) do |q, (column, value)|
        q.where(::Sequel.lit("#{column} > :#{column}",
                             column => value) )
      end
    end
  end
end
