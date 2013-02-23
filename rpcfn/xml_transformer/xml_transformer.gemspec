# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xml_transformer'
Gem::Specification.new do |gem|
  gem.name          = "xml_transformer"
  gem.version       = XmlTransformer::VERSION
  gem.authors       = ["Abhijit Sarkar"]
  gem.description   = %q{XML transformer}
  gem.summary       = %q{XML transformer}
  gem.homepage      = ""

 gem.files         = %w(README Rakefile) + Dir.glob("{lib}/**/*")
  gem.executables   = Dir.glob("{bin}/**/*")
  gem.test_files    = Dir.glob("{test}/**/*")
  gem.require_paths = ["lib"]
end
