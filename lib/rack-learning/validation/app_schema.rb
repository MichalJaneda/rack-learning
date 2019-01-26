class AppSchema < Dry::Validation::Schema
  configure do |config|
    config.messages_file = "#{Dir.pwd}/config/errors.yml"
  end
end
