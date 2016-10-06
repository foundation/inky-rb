require "bundler/gem_tasks"
require 'rubocop/rake_task'

RuboCop::RakeTask.new

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
