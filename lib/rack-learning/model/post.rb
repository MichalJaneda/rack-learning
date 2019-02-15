module Model
  class Post < ::Sequel::Model
    many_to_one :user
  end
end
