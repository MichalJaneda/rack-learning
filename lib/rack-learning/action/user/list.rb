module Action
  module User
    class List < ::Action::Base
      private

      def handle
        serialize(Query::Repository::Users.all,
                  ::Serializer::User)
      end
    end
  end
end
