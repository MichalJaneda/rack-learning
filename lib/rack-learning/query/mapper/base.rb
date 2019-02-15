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
        entities.map { |e| model.new(e) }
      end

      private

      attr_reader :entities, :model
    end
  end
end
