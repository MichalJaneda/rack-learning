#! /usr/bin/env ruby

require 'bundler'
require 'dotenv'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'

router = Hanami::Router.new do
  root to: Action::Greet
end

Rack::Server.start(app: router)
