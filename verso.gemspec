# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "verso/version"

Gem::Specification.new do |s|
  s.name        = "verso"
  s.version     = Verso::VERSION
  s.authors     = ["Lee Capps"]
  s.email       = ["himself@leecapps.com"]
  s.homepage    = "https://github.com/jlcapps/verso"
  s.summary     = %q{Verso API wrapper}
  s.description = %q{A Ruby wrapper for the Virginia CTE Resource Center's Web API}

  s.rubyforge_project = "verso"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'addressable'
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
end
