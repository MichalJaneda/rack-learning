module Routing
  class Router
    def self.routing
      ::Hanami::Router.new do
        root to: Action::Greet
        get '/greet', to: Action::Greet
        post '/user', to: Action::User::Create
      end
    end
  end
end
