module Action
  module User
    class Create < ::Action::Base
      private

      def handle
        validation = ValidationUser.with(repository: Query::Repository::User).(params)
        return handle_failure(validation) if validation.failure?
        response.status = 201
        Query::Repository::User.insert(params)
        serialize(Model::User.find(email: params[:email]),
                  ::Serializer::User)
      end
    end
  end
end
