require 'bundler'

Bundler.require(:default, :test)
Dotenv.load('.env.testing')

require 'open3'

Dir.glob(File.join("#{Dir.pwd}/lib", '**', '*.rb'), &method(:require))
Dir['./spec/support/**/*.rb'].each(&method(:require))

Sequel.extension (:migration)
Sequel::Migrator.check_current(DATABASE_CONNECTION_CONTAINER.resolve(:connection),
                               "#{Dir.pwd}/db/migrations")

SPECIAL_TEST_TYPES = %i(action task validation filter).freeze

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FactoryBot.find_definitions
  end

  config.around(:each) do |example|
    if example.metadata[:type] != :filter
      DatabaseCleaner.cleaning do
        example.run
      end
    else
      example.run
    end
  end

  SPECIAL_TEST_TYPES.each do |test_type|
    config.define_derived_metadata(file_path: Regexp.new("spec/#{test_type}/")) do |metadata|
      metadata[:type] = test_type
    end
  end

  SPECIAL_TEST_TYPES.each do |test_type|
    config.include(Object.const_get("SharedContext::#{test_type.capitalize}"),
                   type: test_type)
  end
end
