module Query
  module Repository
    class Base
      def self.method_missing(method, *args, &block)
        self.dataset.send(method, *args, &block)
      end

      private

      def self.dataset
        table = self.name.split('::').last.downcase.to_sym
        DATABASE_CONNECTION_CONTAINER.resolve(:connection)[table]
      end
    end
  end
end
