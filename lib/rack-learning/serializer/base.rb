module Serializer
  class Base
    ATTRIBUTES = {}

    def initialize(record)
      @record = record.map { |k, v| [k.to_sym, v] }.to_h
    end

    def to_h
      self.class::ATTRIBUTES.map do |key, type|
        if record[key]
          value = if type == String
                    record[key].to_s
                  elsif type == Integer
                    record[key].to_i
                  else
                    record[key]
                  end
          [key, value]
        end
      end.compact.to_h
    end

    private

    attr_reader :attributes, :record
  end
end