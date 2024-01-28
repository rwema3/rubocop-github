# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module GitHub
      # Public: A Rubocop to discourage using methods like Object#send that allow you to dynamically call other
      # methods on a Ruby object, when the method being called is itself completely dynamic. Instead, explicitly call
      # methods by name.
      #
      # Examples:
      #
      #     # bad
      #     foo.send(some_variable)
      #
      #     # good
      #     case some_variable
      #     when "bar"
      #       foo.bar
      #     else
      #       foo.baz
      #     end
      #
      #     # fine
      #     foo.send(:bar)
      #     foo.public_send("some_method")
      #     foo.__send__("some_#{variable}_method")
