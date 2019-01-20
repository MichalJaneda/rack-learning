module Action
  class Base
    # @param [Hash] env
    # @return [Rack::Response]
    def call(env)
      handle(::Rack::Request.new(env))
      response
    end

    private

    # @param [Rack::Request] request
    # @return []
    def handle(request)
      raise NotImplementedError
    end

    def response
      @response ||= ::Rack::Response.new
    end
  end
end
