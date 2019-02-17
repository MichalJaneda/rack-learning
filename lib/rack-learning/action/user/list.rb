module Action
  module User
    class List < ::Action::Base
      private

      def handle
        reduce_and_serialize(Query::Repository::User.order(:email),
                             ::Serializer::User)
      end
    end
  end
end
