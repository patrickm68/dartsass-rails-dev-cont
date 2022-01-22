require "rails"

module Dartsass
  class Engine < ::Rails::Engine
    config.dartsass = ActiveSupport::OrderedOptions.new
    config.dartsass.stylesheets = { "application.scss" => "application.css" }
  end
end
