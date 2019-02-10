module Filter
  class Base
    def initialize(query, where = {})
      @query = query
      @filter = where[self.class.name.split('::').last.downcase.to_sym] || {}
    end

    def call
      apply
      query
    end

    private

    attr_reader :query, :filter

    def apply
      raise NotImplementedError
    end
  end
end
