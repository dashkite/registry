import Value from "./value"

$ = globalThis[ "@dashkite/registry" ] ?= new Map

Registry =

  get: ( key ) ->
    do ({ value } = {}) ->
      if ( $.has key )
        value = $.get key
      else
        value = Value.promise()
        $.set key, value
      value.get()

  has: ( key ) -> $.has key

  hasValue: ( key ) -> ( $.get key )?.value?

  set: ( key, value ) ->
    if ( $.has key )
      ( $.get key ).set value
    else
      $.set key, Value.from value
      value

export default Registry

