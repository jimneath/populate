# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "populate/version"

Gem::Specification.new do |s|
  s.name        = "populate"
  s.version     = Populate::VERSION
  s.authors     = ["Jim Neath"]
  s.email       = ["jimneath@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Populates your development database with fake data}
  s.description = %q{Populates your development database with fake data}

  s.rubyforge_project = "populate"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
