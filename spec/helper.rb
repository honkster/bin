require "rubygems"
require "bundler"
Bundler.setup

$:.unshift(File.expand_path('../../lib', __FILE__))

require 'bin'
require 'spec'

connection = Mongo::Connection.new
DB = connection.db('test')

puts "\n--- Active Support Version: #{ActiveSupport::VERSION::STRING} ---\n"