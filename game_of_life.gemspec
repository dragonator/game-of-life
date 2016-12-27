# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_of_life/version'

Gem::Specification.new do |spec|
  spec.name          = 'game_of_life'
  spec.version       = GameOfLife::VERSION
  spec.authors       = ['Teodor Draganov']
  spec.email         = ['draganov93@gmail.com']

  spec.summary       = 'Ruby implementation of John Conway\'s cellular'        \
                       'automaton - Game of Life.'
  spec.description   = 'The "game" is a zero-player game, meaning that '       \
                       'its evolution is determined by its initial state, '    \
                       'requiring no further input. One interacts with the '   \
                       'Game of Life by creating an initial configuration '    \
                       'and observing how it evolves, or, for advanced '       \
                       '"players", by creating patterns with particular '      \
                       'properties.'
  spec.homepage      = 'TODO: Put your gem\'s website or public repo URL here.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
