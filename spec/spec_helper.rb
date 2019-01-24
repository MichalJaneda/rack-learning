require 'bundler'

Bundler.require(:default, :test)
Dotenv.load('.env.testing')

require_relative '../lib/rack-learning'

Dir['./spec/support/**/*.rb'].each(&method(:require))

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.define_derived_metadata(file_path: /spec\/action\//) do |metadata|
    metadata[:type] = :action
  end

  config.include(SharedContext::Action, type: :action)
  config.include(SharedContext::Task, type: :task)
end
