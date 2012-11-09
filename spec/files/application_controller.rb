require 'refinery/hooks/renderer'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Refinery::Hooks::Renderer
end
