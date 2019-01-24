#! /usr/bin/env ruby

require_relative 'rack-learning'

Rack::Server.start(app: Routing::Router.routing)
