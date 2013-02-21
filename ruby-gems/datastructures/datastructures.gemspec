# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datastructures'
Gem::Specification.new do |gem|
  gem.name          = "datastructures"
  gem.version       = DataStructures::VERSION
  gem.authors       = ["Abhijit Sarkar"]
  gem.description   = %q{Ruby based Data Structures}
  gem.summary       = %q{Ruby based Data Structures like Graph and Priority Queue}
  gem.homepage      = ""

  gem.files         = %w(README Rakefile) + Dir.glob("{lib}/**/*")
  gem.executables   = Dir.glob("{bin}/**/*")
  gem.test_files    = Dir.glob("{test}/**/*")
  gem.require_paths = ["lib"]
end
