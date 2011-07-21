# encoding: UTF-8
require File.expand_path('../lib/bin/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'honkster-bin'
  s.homepage     = 'http://github.com/jnunemaker/bin'
  s.summary      = 'ActiveSupport MongoDB Cache store.'
  s.require_path = 'lib'
  s.authors      = ['John Nunemaker']
  s.email        = ['nunemaker@gmail.com']
  s.version      = Bin::Version
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("{lib,spec}/**/*") + %w[LICENSE Rakefile README.rdoc]

  s.add_dependency              'mongo',          '>= 1.1.1'
  s.add_dependency              'activesupport',  '>= 2.3'
  s.add_development_dependency  'rspec',          '~> 1.3.0'
end
