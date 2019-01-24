require 'bundler'
require 'dotenv'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'
