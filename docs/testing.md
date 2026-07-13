# Testing

## How to test code using the registry

The primary test runner for DashKite projects is `npx genie test`. When writing tests for modules that depend on the registry, creators must manage global state carefully. 

Tests should isolate themselves by ensuring that they either clear the relevant keys or seed the registry with the required mocks before executing the test. This approach prevents side effects from bleeding across test suites.

1. Seed the registry with mock objects using `set`.
2. Execute the logic that calls `get`.
3. Assert the expected outcomes.

```coffeescript
import Registry from "@dashkite/registry"

test "my logic", ->
  # Seed with mock
  Registry.set "application", mockApplication
  
  # Execute logic that calls Registry.get
  await runMyLogic()
```
