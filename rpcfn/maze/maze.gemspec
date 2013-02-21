# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maze'
Gem::Specification.new do |gem|
  gem.name          = "maze"
  gem.version       = Maze::VERSION
  gem.authors       = ["Abhijit Sarkar"]
  gem.description   = %q{Ruby based Maze solution}
  gem.summary       = %q{Ruby based Maze solution}
  gem.homepage      = ""

  gem.files         = %w(README Rakefile) + Dir.glob("{lib}/**/*")
  gem.executables   = Dir.glob("{bin}/**/*")
  gem.test_files    = Dir.glob("{test}/**/*")
  gem.require_paths = ["lib"]
end