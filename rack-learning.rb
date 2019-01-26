require 'bundler'
require 'dotenv'
require 'open3'
require 'logger'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'
