module Model
  class User < ::Sequel::Model
    one_to_many :posts, key: :author
  end
end
