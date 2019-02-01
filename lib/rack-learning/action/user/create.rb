module Action
  module User
    class Create < ::Action::Base
      private

      def handle
        validation = ValidationUser.(params)
        return handle_failure(validation) if validation.failure?
        response.status = 201
        Query::Repository::Users.new.insert(params)
        response.write(params)
      end
    end
  end
end
