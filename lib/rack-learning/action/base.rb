module Action
  class Base
    # @param [Hash] env
    # @return [Rack::Response]
    def call(env)
      create_empty_response
      @request = ::Rack::Request.new(env)
      process
      response
    end

    private

    attr_reader :request, :response

    def handle
      raise NotImplementedError
    end

    def process
      handle
    rescue UnauthorizedError
      response.status = 403
    end

    def handle_failure(validation)
      response.status = 422
      response.write(validation.errors)
    end

    def create_empty_response
      @response = ::Rack::Response.new
      response['Content-Type'] = 'application/json'
    end

    def reduce_and_serialize(query, serializer)
      reduced_query = (params[:where] || {}).reduce(query) do |q, (filter_name, _)|
        filter_class = "::Filter::#{filter_name.capitalize}"
        Object.const_get(filter_class).new(q, params[:where]).call
      rescue NameError
        # unknown filter, just skip
        q
      end

      serialize(::Filter::Limit.new(reduced_query, params[:where]).call
                  .all,
                serializer)
    end

    def serialize(entities, serializer)
      if entities.is_a?(::Array)
        response.write(entities.map { |entity| serializer.new(entity.values).to_h }.to_json)
      else
        response.write(serializer.new(entities.values).to_h.to_json)
      end
    end

    def params
      @params ||= request.params.deep_symbolize_keys
    end

    def headers
      @headers = Hash[*request.env.select {|k,v| k.start_with? 'HTTP_'}
                         .collect {|k,v| [k.sub(/^HTTP_/, ''), v]}
                         .collect {|k,v| [k.split('_').collect(&:capitalize).join('-').to_sym, v]}
                         .sort
                         .flatten].symbolize_keys

    end

    def authorize!
      raise UnauthorizedError if headers[:Authorization].nil? || user.nil?
    end

    def user
      @user ||= Model::User.find(token: headers[:Authorization].sub('Bearer ', ''))
    end
  end
end
