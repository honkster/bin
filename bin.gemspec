# encoding: UTF-8
require File.expand_path('../lib/bin/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'honkster-bin'
  s.homepage = 'http://github.com/jnunemaker/bin'
  s.summary = 'ActiveSupport MongoDB Cache store.'
  s.require_path = 'lib'
  s.authors = ['John Nunemaker']
  s.email = ['nunemaker@gmail.com']
  s.version = Bin::Version
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("{lib,spec}/**/*") + %w[LICENSE Rakefile README.rdoc]

  s.add_dependency 'mongo', '>= 1.0.1'
  s.add_dependency 'bson_ext', '>= 1.0.1'
  s.add_dependency 'activesupport', '>= 3.0'
  s.add_dependency 'i18n', '>= 0.5.0'
  s.add_development_dependency 'rspec', '~> 1.3.0'
  s.add_development_dependency 'ruby-debug19', '>=0.11.6'
  s.add_development_dependency 'diff-lcs', '~> 1.1.2'
end
