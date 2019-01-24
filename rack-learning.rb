require 'bundler'
require 'dotenv'
require 'open3'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'
