module Query
  module Repository
    class Users < Base
      def self.with_posts
        left_join(:posts, author: :email)
      end
    end
  end
end
