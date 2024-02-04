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

        def_node_matcher :render_with_options?, <<-PATTERN
          (send nil? {:render :render_to_string} (hash $...))
        PATTERN

        def_node_matcher :action_key?, <<-PATTERN
          (pair (sym {:action :template}) $(sym _))
        PATTERN

        def on_send(node)
