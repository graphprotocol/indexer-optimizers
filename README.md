# AllocationOpt

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://graphprotocol.github.io/AllocationOpt.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://graphprotocol.github.io/AllocationOpt.jl/dev)
[![Build Status](https://github.com/graphprotocol/AllocationOpt.jl/actions/workflows/CI.yml/badge.svg?branch=)](https://github.com/graphprotocol/AllocationOpt.jl/actions/workflows/CI.yml?query=branch%3A)
[![Coverage](https://codecov.io/gh/graphprotocol/AllocationOpt.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/graphprotocol/AllocationOpt.jl)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)


## Installation

1. Clone this github repository.

```bash
$ git clone git@github.com:graphprotocol/AllocationOpt.jl.git
```

1. [Download](https://julialang.org/downloads/) and install julia locally. You'll need at least Julia 1.7 in order to use this tool.
2. Enter the julia repl. On linux machines, this is as simple as running the `julia` command from your terminal emulator.
3. Enter *shell mode* by typing `;` in the repl.
4. `cd` into the AllocationOpt directory. For example

```julia-repl
shell> cd projects/AllocationOpt.jl
```

5. Exit *shell mode* by hitting `Backspace` and enter *Pkg mode* by pressing `]`.
6. Instantiate the project to install the necessary packages

```julia-repl
pkg> instantiate
```

## Usage

### From the Julia REPL

1. Enter the julia repl. On linux machines, this is as simple as running the `julia` command from your terminal emulator.
2. Enter *shell mode* by typing `;` in the repl.
3. `cd` into the AllocationOpt directory. For example

```julia-repl
shell> cd projects/AllocationOpt.jl
```

4. Exit *shell mode* by hitting `Backspace` and enter *Pkg mode* by pressing `]`.
5. Activate the project environment

```julia-repl
pkg> activate .
```

6. Exit *pkg mode* by pressing `Backspace`.
7. Import the `AllocationOpt` package.
```julia-repl
julia> using AllocationOpt
```
8. Call the `optimize_indexer` function with the relevant arguments.
```julia-repl
julia> optimize_indexer("0x6ac85b9d834b51b14a7b0ed849bb5199e04c05c5", String["QmP4oSiQ7Wc4JTFk86m2JxGvR912NyBbxJnEdZawkYLTk4"], String[], String[], String[])
```
The allocations will be returned as a tuple of ipfs hashs and allocation amounts in GRT.

### The `optimize_indexer` Function

**Arguments:**
```julia
id::AbstractString  # The id of the indexer to optimise.
whitelist::Vector{AbstractString}  # Subgraph deployment IPFS hashes included in this list will be considered for, but not guaranteed allocation.
blacklist::Vector{AbstractString}  # Subgraph deployment IPFS hashes included in this list will not be considered, and will be suggested to close if there's an existing allocation.
pinnedlist::Vector{AbstractString}  # Subgraph deployment IPFS hashes included in this list will be guaranteed allocation. Currently unsupported.
frozenlist::Vector{AbstractString}  # Subgraph deployment IPFS hashes included in this list will not be considered during optimisation. Any allocations you have on these subgraphs deployments will remain.
```
