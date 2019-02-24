module Query
  module Mapper
    class Base
      # @param [Array<Hash>] entities
      def initialize(entities)
        @entities = entities
        @model = Object.const_get("Model::#{self.class.name.split('::').last}")
      end

      # @return [Array<Model>]
      def call
        entities.map do |e|
          m = model.new
          m.set_fields(e, e.keys)
        end
      end

      private

      attr_reader :entities, :model
    end
  end
end
