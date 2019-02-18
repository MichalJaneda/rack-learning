module Routing
  class Router
    def self.routing
      ::Hanami::Router.new do
        root to: Action::Greet
        get '/greet', to: Action::Greet
        get '/user', to: Action::User::List
        post '/user', to: Action::User::Create
        post '/post', to: Action::Post::Create
      end
    end
  end
end
