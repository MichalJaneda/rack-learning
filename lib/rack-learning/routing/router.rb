module Routing
  class Router
    def self.routing
      ::Hanami::Router.new do
        root to: Action::Greet
      end
    end
  end
end
