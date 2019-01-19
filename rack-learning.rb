#! /usr/bin/env ruby

require 'bundler'
require 'dotenv'

Bundler.require(:development)
Dotenv.load('.env.development')

require 'lib/rack-learning'
