require 'bundler'

Bundler.require(:default, :test)
Dotenv.load('.env.testing')

require 'open3'

Dir.glob(File.join("#{Dir.pwd}/lib", '**', '*.rb'), &method(:require))
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

  config.define_derived_metadata(file_path: /spec\/task\//) do |metadata|
    metadata[:type] = :task
  end

  config.define_derived_metadata(file_path: /spec\/validation\//) do |metadata|
    metadata[:type] = :validation
  end

  config.include(SharedContext::Action, type: :action)
  config.include(SharedContext::Task, type: :task)
  config.include(SharedContext::Validation, type: :validation)
end
