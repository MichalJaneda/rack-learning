# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dotenv'
gem 'dry-validation'
gem 'pg'
gem 'hanami-router'
gem 'rack'
gem 'rake'
gem 'sequel'
gem 'trailblazer'

group :test do
  gem 'database_cleaner'
  gem 'rspec'
  gem 'timecop'
  gem 'faker'
end

group :development, :test do
  gem 'pry'
end
