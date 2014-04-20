require 'minitest/autorun'

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
Bundler.require(:default, :development)

require 'webmock/rspec'
require "pagseguro"

require 'shoulda/matchers'

RSpec.configure do |config|
  config.before(:each) do
    load './lib/pagseguro.rb'
  end
end
