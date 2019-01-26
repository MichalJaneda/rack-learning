# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dotenv'
gem 'pg'
gem 'hanami-router'
gem 'rack'
gem 'rake'
gem 'sequel'

group :test do
  gem 'rspec'
  gem 'timecop'
end

group :development, :test do
  gem 'pry'
end
