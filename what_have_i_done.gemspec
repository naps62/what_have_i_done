# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'what_have_i_done/version'

Gem::Specification.new do |gem|
  gem.name          = "what_have_i_don"
  gem.version       = WhatHaveIDone::VERSION
  gem.authors       = ["Miguel Palhas"]
  gem.email         = ["miguel@subvisual.co"]
  gem.description   = %q{Provide me a summary of my toggl work day}
  gem.homepage      = "https://github.com/naps62/what_have_i_done"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ['what_have_i_done']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.licenses      = ['MIT']

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'togglv8'
  gem.add_dependency 'i18n'
  gem.add_dependency 'rainbow'
end
