require 'bundler'
require 'rake'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

task :test do
  puts `ruby test/fancy_dot_reporter_test.rb`
end

task :fancytest do
  puts `ruby test/test_run.rb`
end
