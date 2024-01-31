# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module GitHub
      class InsecureHashAlgorithm < Base
        MSG = "This hash function is not allowed"
        UUID_V3_MSG = "uuid_v3 uses MD5, which is not allowed"
        UUID_V5_MSG = "uuid_v5 uses SHA1, which is not allowed"

        # Matches constants like these:
        #   Digest::MD5
        #   OpenSSL::Digest::MD5
        def_node_matcher :insecure_const?, <<-PATTERN
          (const (const _ :Digest) #insecure_algorithm?)
        PATTERN

