# Recipes

## How to share state globally

This guide explains how to share state across an application to relieve creators from ordering concerns. Common keys shared include `application` (the orchestrator) or `messages` (localized services).

The software enables this by providing a unified global store. Creators can set a value in an initialization module and retrieve it in a consumer module. 

1. Import the registry.
2. Call `set` to register the value.
3. In the consumer, call `get` and await the promise.

```coffeescript
import Registry from "@dashkite/registry"

# Module A (Initialization)
initializeDatabase = ->
  Registry.set "database", connection

# Module B (Usage)
performQuery = ->
  db = await Registry.get "database"
  # interact with db
```

## How to conditionally check for state

This guide explains how to verify if a dependency has been registered or resolved. 

The software enables this via the `has` and `hasValue` methods. The `has` method returns true if a key is registered (even if pending), while `hasValue` returns true only if the promise has resolved.

1. Call `hasValue` to check if the state is fully resolved.
2. Call `has` to check if the state is pending.

```coffeescript
import Registry from "@dashkite/registry"

checkStatus = ->
  if Registry.hasValue "database"
    # Proceed with resolved database
  else if Registry.has "database"
    # Handle pending state
  else
    # Handle missing state
```

## How to decouple logic and dependencies

This guide explains how to use side-effect imports and the registry to decouple modules, making implementations easy to swap.

The software enables this by abstracting the dependency graph into a registry pattern. JavaScript modules guarantee idempotency, allowing language features to handle much of the underlying work natively.

1. In the provider module, instantiate and `set` the dependency in the registry.
2. In the main application, import the provider module for its side effects.
3. In the consumer module, await `get` to fetch the dependency.

```coffeescript
# database.coffee
import Registry from "@dashkite/registry"
import connect from "./db"

Registry.set "database", connect()

# main.coffee
import "./database" # Side-effects import triggers registration

# consumer.coffee
import Registry from "@dashkite/registry"

logic = ->
  db = await Registry.get "database"
  # interact with db
```

## How to share reactive streams

This guide explains how to distribute reactive channels (like topics or reactors) across disparate parts of a system.

The software enables this because any object can be stored as a value. Storing a reactive primitive allows decoupled modules to publish and subscribe to the same stream.

1. Instantiate the reactive stream.
2. Register it using `set`.
3. In another module, `get` the stream and subscribe.

```coffeescript
import Registry from "@dashkite/registry"
import { Topic } from "@dashkite/reactive"

setupStream = ->
  Registry.set "message bar inbox", Topic.make()

monitorMessages = ->
  topic = await Registry.get "message bar inbox"
  subscriberChannel = topic.subscribe()
  # iterate over subscriberChannel.listen()
```
