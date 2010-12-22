# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "auditrail/version"

Gem::Specification.new do |s|
  s.name        = "auditrail"
  s.version     = Auditrail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Luis Galaviz", "Emmanuel Delgado"]
  s.email       = ["emmanuel@crowdint.com", "luis.galaviz@crowdint.com"]
  s.homepage    = "http://github.com/crowdint/auditrail"
  s.summary     = %q{An easy and unobtrusive way to track changes on Active Record models}
  s.description = %q{Track changes on Active Record models based on ActiveSupport::Callbacks and ActiveModel::Dirty}

  s.rubyforge_project = "auditrail"
  s.add_dependency("activerecord", "~> 3.0.1")
  s.add_dependency("railties", "~> 3.0.1")
  s.add_development_dependency("rspec", "~> 2.0.1")
  s.add_development_dependency("sqlite3-ruby")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
