# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chess/version'

Gem::Specification.new do |spec|
  spec.name          = "chess"
  spec.version       = Chess::VERSION
  spec.authors       = ["Dominik Stodolny"]
  spec.email         = ["d.stodolny@gmail.com"]
  spec.summary       = %q{A chess clone in text-mode}
  spec.description   = %q{This is a solution for the final exercise from Ruby Chapter in The Odin Project.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
