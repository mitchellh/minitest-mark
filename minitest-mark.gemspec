$:.unshift File.expand_path("../lib", __FILE__)
require "minitest/mark/version"

Gem::Specification.new do |s|
  s.name          = "minitest-mark"
  s.version       = Minitest::Mark::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mitchell Hashimoto"]
  s.email         = ["mitchell.hashimoto@gmail.com"]
  s.summary       = "minitest-mark provides test marking for minitest"
  s.description   = "minitest-mark provides test marking for minitest"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "minitest-mark"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path  = 'lib'
end

