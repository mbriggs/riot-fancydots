# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "riot-fancydots/version"

Gem::Specification.new do |s|
  s.name        = "riot-fancydots"
  s.version     = Riot::Fancydots::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Briggs"]
  s.email       = ["matt@mattbriggs.net"]
  s.homepage    = "http://rubygems.org/gems/riot-fancydots"
  s.summary     = %q{another take on the Riot::DotMatrixReporter}

  s.add_dependency 'riot'
  s.rubyforge_project = "riot-fancydots"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
