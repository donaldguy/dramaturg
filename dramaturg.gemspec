# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dramaturg/version'

Gem::Specification.new do |spec|
  spec.name          = "dramaturg"
  spec.version       = Dramaturg::VERSION
  spec.authors       = ["Donald Guy"]
  spec.email         = ["fawkes@mit.edu"]
  spec.summary       = %q{A framework for optionally-interactive shell scripts}
  spec.description   = %q{In theater, a dramaturg (or "literary manager") is a behind-the-scenes individual who
researches and advises in the development of dramatic scripts and productions.

This library hopes to allow you to fulfill a similar role, but for shell scripts and cli workflows.

In particular, in the spirit of devops and "learn by doing", it seeks to empower those in-the-know (e.g. ops-types or
senior developers) to deliver a workflow to those-less-so (e.g. junior developers) that can be executed outright—or
easily departed from as desired & appropriate for the user's level of familiarity with the tools & proccess.}
  spec.homepage      = "https://github.com/donaldguy/dramaturg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "madCLIbs", '~> 0.0.5'
  spec.add_dependency "activesupport", '~> 4'



  spec.add_development_dependency "bundler", "~> 1.6"
  #spec.add_development_dependency "rspec"
end
