class AppSchema < Dry::Validation::Schema
  configure do |config|
    config.messages_file = "#{Dir.pwd}/config/errors.yml"

    option :repository

    def unique?(attr_name, value)
      repository.where(attr_name => value).empty?
    end
  end
end
