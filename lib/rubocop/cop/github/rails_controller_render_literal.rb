# frozen_string_literal: true

require "rubocop"
require "rubocop/cop/github/render_literal_helpers"

module RuboCop
  module Cop
    module GitHub
      class RailsControllerRenderLiteral < Base
        include RenderLiteralHelpers

        MSG = "render must be used with a string literal or an instance of a Class"

        def_node_matcher :ignore_key?, <<-PATTERN
          (pair (sym {
            :body
            :file
            :html
            :inline
            :js
            :json
            :nothing
            :plain
            :text
            :xml
          }) $_)
        PATTERN

        def_node_matcher :template_key?, <<-PATTERN
          (pair (sym {
            :action
            :partial
            :template
          }) $_)
        PATTERN

        def_node_matcher :layout_key?, <<-PATTERN
          (pair (sym :layout) $_)
        PATTERN

        def_node_matcher :options_key?, <<-PATTERN
          (pair (sym {
            :content_type
            :location
            :status
            :formats
          }) ...)
        PATTERN

