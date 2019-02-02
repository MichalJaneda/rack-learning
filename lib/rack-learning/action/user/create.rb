module Action
  module User
    class Create < ::Action::Base
      private

      def handle
        validation = ValidationUser.(params)
        return handle_failure(validation) if validation.failure?
        response.status = 201
        Query::Repository::Users.insert(params)
        serialize(params,
                  ::Serializer::User)
      end
    end
  end
end
