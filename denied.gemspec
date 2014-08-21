# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'denied/version'

Gem::Specification.new do |spec|
  spec.name          = "denied"
  spec.version       = Denied::VERSION
  spec.authors       = ["Johannes Opper"]
  spec.email         = ["johannes.opper@gmail.com"]
  spec.summary       = %q{Simple access control dsl for controllers.}
  spec.description   = %q{Simple access control dsl for controllers}
  spec.homepage      = "https://github.com/xijo/denied"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
