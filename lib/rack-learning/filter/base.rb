module Filter
  class Base
    def initialize(query,
                   where = {},
                   default: nil,
                   check: ->() { true })
      @query = query
      @filter = where[self.class.name.split('::').last.downcase.to_sym] || {}
      @default = default
    end

    def call
      apply
      query
    end

    private

    attr_reader :query, :filter, :default

    def apply
      raise NotImplementedError
    end
  end
end
