# Ensure we require the local version and not one we might have installed already
#require File.join([File.dirname(__FILE__),'lib','todo_version.rb'])
$:.push File.expand_path("../lib", __FILE__)
require "todo_version"


spec = Gem::Specification.new do |s| 
  s.name = 'todo'
  s.version = Todo::VERSION
  s.author = ''
  s.email = ''
  s.homepage = 'http://github.com/jihao'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.executables << 'todo'
  s.add_dependency('gli')
  s.add_dependency('rainbow')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba', '~> 0.4.6')
end
