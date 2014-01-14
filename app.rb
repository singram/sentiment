# encoding: utf-8
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'bootstrap_jars'

class Sentiment < Sinatra::Application

  configure :production do
    set :clean_trace, true
  end

end

require_relative 'models/init'
require_relative 'routes/init'
