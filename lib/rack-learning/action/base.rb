module Action
  class Base
    # @param [Hash] env
    # @return [Rack::Response]
    def call(env)
      create_empty_response
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

    def create_empty_response
      @response = ::Rack::Response.new
      response['Content-Type'] = 'application/json'
    end

    def serialize(entities, serializer)
      if entities.is_a?(::Array)
        response.write(entities.map { |entity| serializer.new(entity).to_h }.to_json)
      else
        response.write(serializer.new(entities).to_h.to_json)
      end
    end

    def params
      @params ||= request.params.deep_symbolize_keys
    end
  end
end
