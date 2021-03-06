require 'bundler'
require 'dotenv'
require 'open3'
require 'logger'
require 'uri'
require 'optparse'

Bundler.require(:default, :development)

options = {
  environment: ENV['ENV'] || 'development'
}

Dotenv.load(".env.#{options[:environment]}")

Dir.glob(File.join("#{Dir.pwd}/lib", '**', '*.rb'), &method(:require))

unless %w(db:create db:migrate).include?(ARGV[0])
  Sequel.extension (:migration)
  Sequel::Migrator.check_current(DATABASE_CONNECTION_CONTAINER.resolve(:connection),
                                 "#{Dir.pwd}/db/migrations")
end
