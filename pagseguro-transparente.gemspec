# coding: utf-8
require "./lib/pagseguro/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 1.9.3"
  spec.name                  = "pagseguro-transparente"
  spec.version               = PagSeguro::VERSION
  spec.authors               = ["Cirdes Henrique"]
  spec.email                 = ["cirdes@gmail.com"]
  spec.description           = "Integração com o novo checkout transparente do Pagseguro."
  spec.summary               = spec.description
  spec.homepage              = "http://www.eventick.com.br"
  spec.license               = "MIT"

  spec.files                 = `git ls-files`.split($/)
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "json"
  spec.add_dependency "activemodel"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "shoulda-matchers", '2.5.0'
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'thread_safe', '0.2.0'
  #spec.add_development_dependency "pry-meta"
  #spec.add_development_dependency "autotest-standalone"
end
