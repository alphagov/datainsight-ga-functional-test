require "capybara"
require "capybara/cucumber"
require 'capybara/poltergeist'

Capybara.app_host= 'http://localhost:8080'
Capybara.default_selector= :css
Capybara.default_driver = :poltergeist

include Capybara::DSL

def host
  Capybara.app_host
end