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

    def handle_failure(validation)
      response.status = 422
      response.write(validation.errors)
    end

    def params
      request.params.map { |k, v| [k.to_sym, v] }.to_h
    end
  end
end
