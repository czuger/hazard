# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hazard/version'

Gem::Specification.new do |spec|

  spec.name          = 'hazard'
  spec.version       = Hazard::VERSION
  spec.authors       = ['Cédric ZUGER']
  spec.email         = ['zuger.cedric@gmail.com']

  spec.summary       = 'Dice library for ruby'
  spec.description   = 'A very simple dice library for ruby'
  spec.homepage      = 'https://github.com/czuger/hazard'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/).reject{ |e| e =~ /bin/ }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.required_ruby_version = '>= 2.0'

end
