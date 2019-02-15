module Query
  module Repository
    class Base
      def self.method_missing(method, *args, &block)
        self.dataset.send(method, *args, &block)
      end

      private

      def self.dataset
        Object.const_get("Model::#{self.name.split('::').last}")
      end
    end
  end
end
