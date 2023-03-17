# Copyright 2022-, The Graph Foundation
# SPDX-License-Identifier: MIT

const ethtogrt = 1e18
const pinnedamount = 0.1

"""
    togrt(x::AbstractString)

Convert `x` to GRT.

!!! note
    This function is meant to be used with freshly queried data, so it operates on strings.

```julia
julia> using AllocationOpt
julia> AllocationOpt.togrt("1")
```
"""
togrt(x::AbstractString) = parse(Float64, x) / ethtogrt


"""
    totalsupply(::Val{:network}, x)

The total GRT supply.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
    Dict(
        "id" => 1,
        "totalSupply" => 1,
        "networkGRTIssuance" => 1,
        "epochLength" => 28,
        "totalTokensSignalled" => 2,
        "currentEpoch" => 1,
    )
])
julia> AllocationOpt.totalsupply(Val(:network), n)
"""
totalsupply(::Val{:network}, x) = x.totalSupply |> only

"""
    blockissuance(::Val{:network}, x)

The tokens issued per block.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
    Dict(
        "id" => 1,
        "totalSupply" => 1,
        "networkGRTIssuance" => 1,
        "epochLength" => 28,
        "totalTokensSignalled" => 2,
        "currentEpoch" => 1,
    )
])
julia> AllocationOpt.blockissuance(Val(:network), n)
"""
blockissuance(::Val{:network}, x) = x.networkGRTIssuance |> only

"""
    blocksperepoch(::Val{:network}, x)

The number of blocks in each epoch.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
    Dict(
        "id" => 1,
        "totalSupply" => 1,
        "networkGRTIssuance" => 1,
        "epochLength" => 28,
        "totalTokensSignalled" => 2,
        "currentEpoch" => 1,
    )
])
julia> AllocationOpt.blocksperepoch(Val(:network), n)
"""
blocksperepoch(::Val{:network}, x) = x.epochLength |> only

"""
    signal(::Val{:network}, x)

The total signal in the network

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
    Dict(
        "id" => 1,
        "totalSupply" => 1,
        "networkGRTIssuance" => 1,
        "epochLength" => 28,
        "totalTokensSignalled" => 2,
        "currentEpoch" => 1,
    )
])
julia> AllocationOpt.signal(Val(:network), n)
"""
signal(::Val{:network}, x) = x.totalTokensSignalled |> only

"""
    currentepoch(::Val{:network}, x)

The current epoch.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
    Dict(
        "id" => 1,
        "totalSupply" => 1,
        "networkGRTIssuance" => 1,
        "epochLength" => 28,
        "totalTokensSignalled" => 2,
        "currentEpoch" => 1,
    )
])
julia> AllocationOpt.currentepoch.(Val(:network), n)
"""
currentepoch(::Val{:network}, x) = x.currentEpoch |> only

"""
    ipfshash(::Val{:allocation}, x)

Get the ipfs hash of `x` when `x` is part of the allocation table.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "subgraphDeployment.ipfsHash" => "Qma",
    ),
])
julia> AllocationOpt.ipfshash(Val(:allocation), x)
```
"""
ipfshash(::Val{:allocation}, x) = getproperty(x, Symbol("subgraphDeployment.ipfsHash"))

"""
    stake(::Val{:allocation}, x)

Get the allocated tokens for each allocation in `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "allocatedTokens" => 1,
    ),
])
julia> AllocationOpt.stake(Val(:allocation), x)
```
"""
stake(::Val{:allocation}, x) = x.allocatedTokens

"""
    id(::Val{:allocation}, x)

Get the allocation id for each allocation in `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "id" => "0x1"
    ),
])
julia> AllocationOpt.id(Val(:allocation), x)
```
"""
id(::Val{:allocation}, x) = x.id

"""
    ipfshash(::Val{:subgraph}, x)

Get the ipfs hash of `x` when `x` is part of the allocation table.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "ipfsHash" => "Qma",
    ),
])
julia> AllocationOpt.ipfshash(Val(:allocation), x)
```
"""
ipfshash(::Val{:subgraph}, x) = x.ipfsHash

"""
    stake(::Val{:subgraph}, x)

The tokens staked on the subgraphs in table `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict("stakedTokens" => 10,),
    Dict("stakedTokens" => 5,),
])
julia> AllocationOpt.stake(Val(:subgraph), x)
```
"""
stake(::Val{:subgraph}, x) = x.stakedTokens

"""
    signal(::Val{:subgraph}, x)

The tokens signalled on the subgraphs in table `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict("signalledTokens" => 10,),
    Dict("signalledTokens" => 5,),
])
julia> AllocationOpt.signal(Val(:subgraph), x)
```
"""
signal(::Val{:subgraph}, x) = x.signalledTokens

"""
    stake(::Val{:indexer}, x)

The tokens staked by the indexer in table `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "stakedTokens" => 10,
    ),
])
julia> AllocationOpt.stake(Val(:indexer), x)
```
"""
stake(::Val{:indexer}, x) = x.stakedTokens |> only

"""
    delegation(::Val{:indexer}, x)

The tokens delegated to the indexer in table `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "delegatedTokens" => 10,
    ),
])
julia> AllocationOpt.delegation(Val(:indexer), x)
```
"""
delegation(::Val{:indexer}, x) = x.delegatedTokens |> only

"""
    locked(::Val{:indexer}, x)

The locked tokens of the indexer in table `x`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> x = flextable([
    Dict(
        "lockedTokens" => 10,
    ),
])
julia> AllocationOpt.locked(Val(:indexer), x)
```
"""
locked(::Val{:indexer}, x) = x.lockedTokens |> only

"""
    frozen(a::FlexTable, config::AbstractDict)

The frozen stake of the indexer with allocations `a`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> a = flextable([
            Dict("subgraphDeployment.ipfsHash" => "Qma", "allocatedTokens" => 5),
            Dict("subgraphDeployment.ipfsHash" => "Qmb", "allocatedTokens" => 10),
       ])
julia> config = Dict("frozenlist" => ["Qma", "Qmb"])
julia> AllocationOpt.frozen(a, config)
```
"""
function frozen(a::FlexTable, config::AbstractDict)
    frozenallocs = SAC.filterview(r -> ipfshash(Val(:allocation), r) ∈ config["frozenlist"], a)
    return sum(stake(Val(:allocation), frozenallocs); init=0.0)
end

"""
    pinned(config::AbstractDict)

The pinned stake of the indexer.

```julia
julia> using AllocationOpt
julia> config = Dict("pinnedlist" => ["Qma", "Qmb"])
julia> AllocationOpt.pinned(config)
```
"""
pinned(config::AbstractDict) = pinnedamount * length(config["pinnedlist"])

"""
     allocatablesubgraphs(s::FlexTable, config::AbstractDict)

For the subgraphs `s` return a view of the subgraphs on which we can allocate.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> s = flextable([
            Dict("ipfsHash" => "Qma", "signalledTokens" => 10,),
            Dict("ipfsHash" => "Qmb", "signalledTokens" => 20),
            Dict("ipfsHash" => "Qmc", "signalledTokens" => 5),
       ])
julia> config = Dict(
            "whitelist" => String["Qmb", "Qmc"],
            "blacklist" => String[],
            "frozenlist" => String[]
            "min_signal" => 0.0
)
julia> fs = AllocationOpt.allocatablesubgraphs(s, config)
```
"""
function allocatablesubgraphs(s::FlexTable, config::AbstractDict)
    # If no whitelist, whitelist is all subgraphs
    whitelist =
        isempty(config["whitelist"]) ? ipfshash(Val(:subgraph), s) : config["whitelist"]

    # For filtering, blacklist contains both the blacklist and frozenlist,
    # since frozen allocations aren't considered during optimisation.
    blacklist = config["blacklist"] ∪ config["frozenlist"]

    # Anonymous function that returns true if an ipfshash is in the
    # whitelist and not in the blacklist
    f = x -> x ∈ whitelist && !(x ∈ blacklist)

    # Only choose subgraphs with enough signal
    minsignal = config["min_signal"]
    g = x -> x ≥ minsignal

    # Filter the subgraph table by our anonymous function
    fs = SAC.filterview(s) do r
        x = ipfshash(Val(:subgraph), r)
        y = signal(Val(:subgraph), r)
        return f(x) && g(y)
    end
    return fs
end

"""
    newtokenissuance(n::FlexTable, config::Dict)

How many new tokens are issued over the allocation lifetime given network parameters `n`.

```julia
julia> using AllocationOpt
julia> using TheGraphData
julia> n = flextable([
            Dict(
                "id" => 1,
                "totalSupply" => 1,
                "networkGRTIssuance" => 2,
                "epochLength" => 1,
                "totalTokensSignalled" => 2,
                "currentEpoch" => 1,
            )
        ])
julia> config = Dict("allocation_lifetime" => 1)
julia> AllocationOpt.newtokenissuance(n, config)
```
"""
function newtokenissuance(n::FlexTable, config::Dict)
    p = totalsupply(Val(:network), n)
    r = blockissuance(Val(:network), n)
    t = blocksperepoch(Val(:network), n) * config["allocation_lifetime"]

    newtokens = p*(r^t - 1.0)
    return newtokens
end

"""
    function indexingreward(
        x::AbstractVector{Real},
        Ω::AbstractVector{Real},
        ψ::AbstractVector{Real},
        Φ::Real,
        Ψ::Real
    )

The indexing rewards for the allocation vector `x` given signals `ψ`, the existing
allocations on subgraphs `Ω`, token issuance `Φ`, and total signal `Ψ`.

```julia
julia> using AllocationOpt
julia> ψ = [0.0, 1.0]
julia> Ω = [0.0, 0.0]
julia> Φ = 1.0
julia> Ψ = 2.0
julia> x = [0.0, 1.0]
julia> AllocationOpt.indexingreward(x, Ω, ψ, Φ, Ψ)
```
"""
function indexingreward(
    x::AbstractVector{T},
    Ω::AbstractVector{T},
    ψ::AbstractVector{T},
    Φ::Real,
    Ψ::Real
) where {T<:Real}
    return indexingreward.(x, Ω, ψ, Φ, Ψ) |> sum
end

"""
    indexingreward(x::Real, Ω::Real, ψ::Real, Φ::Real, Ψ::Real)

The indexing rewards for the allocation scalar `x` given signals `ψ`, the existing
allocation on subgraphs `Ω`, token issuance `Φ`, and total signal `Ψ`.

```julia
julia> using AllocationOpt
julia> ψ = 0.0
julia> Ω = 1.0
julia> Φ = 1.0
julia> Ψ = 2.0
julia> x = 1.0
julia> AllocationOpt.indexingreward(x, Ω, ψ, Φ, Ψ)
```
"""
function indexingreward(x::Real, Ω::Real, ψ::Real, Φ::Real, Ψ::Real)
    sr = Φ * ψ / Ψ
    return sr * x / (x + Ω)
end

"""
    profit(r::Real, g::Real)

Compute the profit for one allocation with reward `r` and gas cost `g`.

```julia
julia> using AllocationOpt
julia> r = 10
julia> g = 1
julia> AllocationOpt.profit(r, g)
```
"""
profit(r::Real, g::Real) = r == 0 ? 0 : r - g
