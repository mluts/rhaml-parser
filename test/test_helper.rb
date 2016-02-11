require 'bundler/setup'
$:.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'minitest/reporters'
require 'rhaml/parser'
$-d = true if ENV['DEBUG']

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
