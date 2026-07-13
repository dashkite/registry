# Reference

## get

$get: key \dashrightarrow promise\_or\_value$

Retrieves the value for the specified key. If the key does not exist yet, it returns a promise that acts as an implicit state machine, pausing execution until the value is eventually set. If the key already exists and has a value, it returns the value directly.

<example>
```coffeescript
value = await Registry.get "my-key"
```
</example>

## sync.get

$sync.get: key \to value$

Synchronously retrieves the value for the specified key. If the key does not exist, or if the key exists but its value is still pending, this method throws an error.

<example>
```coffeescript
value = Registry.sync.get "my-key"
```
</example>

## has

$has: key \to boolean$

Returns true if the key exists in the registry, even if its value has not yet been resolved.

<example>
```coffeescript
assert.ok Registry.has "my-key"
```
</example>

## hasValue

$hasValue: key \to boolean$

Returns true if the key exists in the registry and its value has been resolved.

<example>
```coffeescript
assert.ok Registry.hasValue "my-key"
```
</example>

## set

$set: key, value \to value$

Registers a value or service under a specific key. This triggers the implicit state machine, resolving any pending promises and allowing dependent code paths to proceed.

<example>
```coffeescript
Registry.set "my-key", "some-value"
```
</example>
