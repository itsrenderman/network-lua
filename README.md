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
  - "UnreliableCallable"

---

## Usage

There are currently four supported methods of interacting with **network-lua**:

1. `Network.Remotes` (a table `[string]: RemoteEvent | RemoteFunction`) of existing remotes

2. `Network:Reserve("name", RemoteType)` (returns an existing remote or calls `Network:Create(...)` if one doesn't exist)

3. `Network:Create("name", RemoteType)`

4. `Network:Destroy("name")`
