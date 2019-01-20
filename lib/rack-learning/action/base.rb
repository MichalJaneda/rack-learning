module Action
  class Base
    def initialize
      @response = ::Rack::Response.new
    end

    # @param [Hash] env
    # @return [Rack::Response]
    def call(env)
      @request = ::Rack::Request.new(env)
      handle
      response
    end

    private

    attr_reader :request, :response

    def handle
      raise NotImplementedError
    end
  end
end
