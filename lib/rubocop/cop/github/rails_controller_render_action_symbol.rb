# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module GitHub
      class RailsControllerRenderActionSymbol < Base
        extend AutoCorrector

        MSG = "Prefer `render` with string instead of symbol"

