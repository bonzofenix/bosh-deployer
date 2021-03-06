# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bosh-deployer'

Gem::Specification.new do |gem|
  gem.name          = "bosh-deployer"
  gem.version       = Bosh::Deployer::VERSION
  gem.authors       = ["Alan Moran"]
  gem.email         = ["bonzofenix@gmail.com"]
  gem.description   = %q{ CLI plugin for bosh to perform different deploying tasks}
  gem.summary       = <<-EOS
            bosh-deployer can:
              - downloads and upload stemcells specifies on a manifest
              pending:
              - deploy Bosh
              - deploy CF
  EOS
  gem.homepage      = "https://github.com/bonzofenix/bosh-deployer"

  gem.required_ruby_version = '>= 1.9'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor", "~> 0.18"
  gem.add_dependency 'readwritesettings'
  gem.add_dependency "cancun"
  gem.add_dependency "recursive-open-struct"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
