# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module GitHub
      class InsecureHashAlgorithm < Base
        MSG = "This hash function is not allowed"
        UUID_V3_MSG = "uuid_v3 uses MD5, which is not allowed"
        UUID_V5_MSG = "uuid_v5 uses SHA1, which is not allowed"

