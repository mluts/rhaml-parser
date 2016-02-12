$:.unshift File.expand_path('../lib', __FILE__)
require 'rhaml/parser/version'

Gem::Specification.new do |s|
  s.name                  = 'rhaml-parser'
  s.version               = RHaml::Parser::VERSION
  s.platform              = Gem::Platform::RUBY
  s.summary               = 'A parser for rhaml'
  s.description           = "Parser implementation for rhaml. It uses ragel underhood."
  s.author                = "Michael Lutsiuk"
  s.email                 = 'michael.lutsiuk@gmail.com'
  s.homepage              = 'https://github.com/mluts/rhaml-parser'
  s.required_ruby_version = '>= 2.0.0'
  s.files                 = %w(README.md Rakefile Gemfile Gemfile.lock) + Dir["{lib}/**/*"]
  s.require_path          = "lib"
end
