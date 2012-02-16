# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "abrio/version"

Gem::Specification.new do |s|
  s.name        = "abrio"
  s.version     = Abrio::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roger Leite"]
  s.email       = ["roger.leite@abril.com.br"]
  s.homepage    = ""
  s.summary     = %q{Client ruby para o encurtador http://abr.io}
  s.description = %q{Client ruby para o encurtador http://abr.io}
  s.required_ruby_version = ">= 1.8.7"

  #s.rubyforge_project = "abrio"
  s.add_development_dependency "turn", "~> 0.8.2"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
  s.add_development_dependency "mocha", "~> 0.9.12"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
