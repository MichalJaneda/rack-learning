module Action
  module Post
    class Create < ::Action::Base
      private

      def handle
        authorize!
        operation = Operation::Post::Create.(params, current_user: user)
        if operation.success?
          response.status = 201
          serialize(operation['model'],
                    Serializer::Post)
        else
          response.status = 422
        end
      end
    end
  end
end
