module Query
  module Repository
    class User < Base
      def self.with_posts
        eager(:posts)
      end

      def self.with_posts_having_views_over(popularity = 0)
        eager(posts: ->(ds) { ds.where { views >= popularity } } )
      end

      def self.having_popular_posts(popularity = 0)
        association_inner_join(posts: ->(ds) { ds.where { views >= popularity } })
      end
    end
  end
end
