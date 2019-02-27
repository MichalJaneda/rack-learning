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

      def self.eagerly_publishing(less_than_days = 1)
        window = ::Model::Post.dataset
                   .select do
          ::Sequel.as(lag(created_at).over(partition: :author,
                                           order: :created_at),
                      :previous_post_created_at)
        end.select_append(:created_at, :author)

        with(:p_o_u_d_i_d, window).join(:p_o_u_d_i_d, author: :email)
          .where do
            Sequel.function(age, created_at,
                            previous_post_created_at) < "#{less_than_days} DAYS"
          end
      end
    end
  end
end
