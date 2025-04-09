import Value from "./value"

$ = globalThis[ "@dashkite/registry" ] ?= new Map

Registry =

  sync:

    get: ( key ) ->
      if ( $.has key )
        wrapper = $.get key
        if Object.hasOwn wrapper, "value"
          wrapper.value
        else
          throw new Error "registry:
            synchronous get of promised value for
            [ #{ key } ]"
      else
        throw new Error "registry:
          synchronous get of non-existent key
          [ #{ key } ]"

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

