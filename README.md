# Registry

*In-memory global key-value store*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Registry provides a unified, in-memory, global key-value store. It allows different parts of an application to share state across modules by attaching a store to the global scope.

## Features

- Provides a global key-value map accessible anywhere in your application.
- Supports asynchronous retrieval; requesting a value before it is set returns a promise that resolves once the value is available.
- Offers synchronous retrieval for values that are guaranteed to be present.
- Avoids module instantiation issues by storing state on `globalThis`.

## Installation

```bash
pnpm install @dashkite/registry
```

## Usage

Registry provides a mechanism to set and retrieve global values. If you retrieve a value before it has been set, you receive a promise that resolves when the value is eventually provided.

```coffeescript
import Registry from "@dashkite/registry"

# Set a value globally
Registry.set "database-connection", dbInstance

# Retrieve it elsewhere
connection = await Registry.get "database-connection"
```

## Other Resources

- [Reference Documentation](docs/reference.md)
- [Usage Guides](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing](docs/testing.md)
