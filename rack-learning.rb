require 'bundler'
require 'dotenv'
require 'open3'
require 'logger'
require 'uri'

Bundler.require(:default, :development)
Dotenv.load('.env.development')

Dir.glob(File.join("#{Dir.pwd}/lib", '**', '*.rb'), &method(:require))
