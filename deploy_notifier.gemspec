# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deploy_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = 'deploy_notifier'
  spec.version       = DeployNotifier::VERSION
  spec.authors       = ['Ruslan Khaertdinov']
  spec.email         = ['ruslanimos@ya.ru']

  spec.summary       = 'RocketChat reports on deploy'
  spec.description   = 'Sends a message on success or failure of deploy to the specific channel'
  spec.homepage      = 'https://github.com/ruslankhaertdinov/deploy_notifier'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'rocket-chat-notifier', '~> 0.1.0'
end
