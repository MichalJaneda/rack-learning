#! /usr/bin/env ruby

require 'bundler'
require 'dotenv'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'

app = Proc.new do
  ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

Rack::Handler::WEBrick.run app
