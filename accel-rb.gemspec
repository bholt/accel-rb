# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'accel/version'

Gem::Specification.new do |spec|
  spec.name          = "accel-rb"
  spec.version       = Accel::VERSION
  spec.authors       = ["Brandon Holt"]
  spec.email         = ["bholt@cs.washington.edu"]
  spec.description   = %q{Small Ruby helpers for making life easier, especially for bash-style scripting tasks.}
  spec.summary       = %q{Helpers for tasks such as writing shell scripts, using Pry effectively, etc.}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pry"
  spec.add_dependency "pry-debugger"
  spec.add_dependency "grit"
  spec.add_dependency "rugged"
  spec.add_dependency "awesome_print"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
