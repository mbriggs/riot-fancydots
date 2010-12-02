require 'rubygems'
require 'riot'
require 'stringio'
require File.expand_path('../../lib/riot-fancydots', __FILE__)
Riot.reporter = Riot::FancyDotReporter

context 'FancyDotReporter' do
  context 'pass' do
    asserts('looks like') {true}
  end
  context 'fail' do
    asserts('looks like') {'foo'}.matches('bar')
  end
  context 'error' do
    asserts('looks like') {raise 'boom'}
  end
end
