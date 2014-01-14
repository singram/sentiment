# encoding: utf-8
require 'java'

Dir.glob('lib/*.jar') do | jar |
  require File.expand_path("../#{jar}", __FILE__)
end
