module Query
  module Repository
    class Users
      def method_missing(method, *args, &block)
        dataset.send(method, *args, &block)
      end

      private

      def dataset
        Connection.get_connection[:users]
      end
    end
  end
end
