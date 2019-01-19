#! /usr/bin/env ruby

require 'bundler'
require 'dotenv'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

require_relative 'lib/rack-learning'

router = require_relative 'lib/rack-learning/router'

Rack::Server.start(app: router)
