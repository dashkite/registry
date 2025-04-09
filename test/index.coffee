import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import $ from "../src"

do ->

  print await test "Helium", [

    test "get", ->
      assert ( $.get "foo" ).then?

    test "set", ->
      $.set "foo", "bar"
      assert.equal "bar", await $.get "foo"

    test "has", ->
      assert $.has "foo"

    test "hasValue", [

      test "no value", ->
        assert ! $.hasValue "a"

      test "promised value", ->
        $.get "a"
        assert ! $.hasValue "a"

      test "a value", ->
        $.set "b", 1
        assert.equal $.hasValue "b"

    ]

    test "sync", [

      test "get", ->
        $.set "sync a", true
        assert $.sync.get "sync a"
        assert.throws ->
          $.sync.get "sync b"
    ]
      

  ]


  process.exit if success then 0 else 1
