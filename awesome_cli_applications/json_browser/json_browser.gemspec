# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "json_browser/version"

Gem::Specification.new do |s|
  s.name        = "json_browser"
  s.version     = JsonBrowser::VERSION
  s.authors     = ["jihao"]
  s.email       = ["jacky.jihao@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "json_browser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "json"
  s.add_runtime_dependency "json"
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
