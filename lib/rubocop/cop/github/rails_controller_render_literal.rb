# frozen_string_literal: true

require "rubocop"
require "rubocop/cop/github/render_literal_helpers"

module RuboCop
  module Cop
    module GitHub
      class RailsControllerRenderLiteral < Base
        include RenderLiteralHelpers

        MSG = "render must be used with a string literal or an instance of a Class"

