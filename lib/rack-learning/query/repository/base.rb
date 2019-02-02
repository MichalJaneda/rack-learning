module Query
  module Repository
    class Base
      def self.method_missing(method, *args, &block)
        DATABASE_CONNECTION_CONTAINER.resolve(:connection)[self::DATASET]
          .send(method, *args, &block)
      end
    end
  end
end
