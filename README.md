# network-lua
A simple Luau module to assist with creating, storing and destroying remotes on Roblox

---

## Installation

Simply add the module to your game, run and store it (eg. `local Network = require(ReplicatedStorage.Network)`), and use the appropriate syntax listed below.

---

## Exported Types

### RemoteType

- A string of either:
  - "Callable"
  - "Invokable"

---

## Usage

There are currently five supported methods of interacting with **network-lua**:

1. `Network("name", RemoteType)` (alias for `Network:Reserve(...)`)

2. `Network.Remotes` (a table `[string]: RemoteEvent | RemoteFunction`) of existing remotes

3. `Network:Reserve("name", RemoteType)` (returns an existing remote or calls `Network:Create(...)` if one doesn't exist)

4. `Network:Create("name", RemoteType)`

5. `Network:Destroy("name")`
