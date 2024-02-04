# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module GitHub
      class RailsControllerRenderActionSymbol < Base
        extend AutoCorrector

        MSG = "Prefer `render` with string instead of symbol"

        def_node_matcher :render_sym?, <<-PATTERN
          (send nil? {:render :render_to_string} $(sym _))
        PATTERN

