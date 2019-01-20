module Action
  class Base
    # @param [Hash] env
    # @return [Rack::Response]
    def call(env)
      @response = ::Rack::Response.new
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
