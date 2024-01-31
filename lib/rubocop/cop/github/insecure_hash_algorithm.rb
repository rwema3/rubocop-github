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

        # Matches calls like these:
        #   Digest.new('md5')
        #   Digest.hexdigest('md5', 'str')
        #   OpenSSL::Digest.new('md5')
        #   OpenSSL::Digest.hexdigest('md5', 'str')
        #   OpenSSL::Digest::Digest.new('md5')
        #   OpenSSL::Digest::Digest.hexdigest('md5', 'str')
        #   OpenSSL::Digest::Digest.new(:MD5)
        #   OpenSSL::Digest::Digest.hexdigest(:MD5, 'str')
        def_node_matcher :insecure_digest?, <<-PATTERN
          (send
            (const _ {:Digest :HMAC})
            #not_just_encoding?
            #insecure_algorithm?
            ...)
        PATTERN

        # Matches calls like "Digest(:MD5)".
        def_node_matcher :insecure_hash_lookup?, <<-PATTERN
          (send _ :Digest #insecure_algorithm?)
        PATTERN

        # Matches calls like "OpenSSL::HMAC.new(secret, hash)"
        def_node_matcher :openssl_hmac_new?, <<-PATTERN
          (send (const (const _ :OpenSSL) :HMAC) :new ...)
        PATTERN

        # Matches calls like "OpenSSL::HMAC.new(secret, 'sha1')"
        def_node_matcher :openssl_hmac_new_insecure?, <<-PATTERN
          (send (const (const _ :OpenSSL) :HMAC) :new _ #insecure_algorithm?)
        PATTERN

        # Matches Rails's Digest::UUID.
        def_node_matcher :digest_uuid?, <<-PATTERN
          (const (const _ :Digest) :UUID)
        PATTERN

        def_node_matcher :uuid_v3?, <<-PATTERN
          (send (const _ :UUID) :uuid_v3 ...)
        PATTERN

