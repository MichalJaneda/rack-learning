module Operation
  module Post
    class Create < ::Trailblazer::Operation
      step ->(options) { ValidationPost.with(repository: Query::Repository::Post).(options['params']).success? }
      success :init_model!
      step :attach_author
      step :save!

      def init_model!(options, params:, **)
        options['model'] = ::Model::Post.new
        options['model'].set_fields(params, %i(title body))
      end

      def attach_author(options, current_user:, model:, **)
        return false unless current_user
        model.author = current_user.email
        true
      end

      def save!(options, model:, **)
        model.save
      end
    end
  end
end
