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

Sequel.extension (:migration)
Sequel::Migrator.check_current(Connection.new.connection, "#{Dir.pwd}/db/migrations")
