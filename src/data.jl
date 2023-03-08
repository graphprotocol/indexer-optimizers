# Copyright 2022-, The Graph Foundation
# SPDX-License-Identifier: MIT

"""
    squery()

Return the components of a GraphQL query for subgraphs.

For use with the TheGraphData.jl package.

```julia
julia> using AllocationOpt
julia> value, args, fields = AllocationOpt.squery()
```

# Extended Help
You can find TheGraphData.jl at https://github.com/semiotic-ai/TheGraphData.jl
"""
function squery()
    v = "subgraphDeployments"
    a = Dict{String,Union{Dict{String,String},String}}()
    f = ["ipfsHash", "signalledTokens"]
    return v, a, f
end

"""
    iquery()

Return the components of a GraphQL query for indexers.

For use with the TheGraphData.jl package.

!!! note
    This currently only gets the first 1000 indexers with staked tokens ≥ 100k GRT

```julia
julia> using AllocationOpt
julia> value, args, fields = AllocationOpt.iquery()
```

# Extended Help
You can find TheGraphData.jl at https://github.com/semiotic-ai/TheGraphData.jl
"""
function iquery()
    v = "indexers"
    a = Dict{String,Union{Dict{String,String},String,Int64}}(
        "first" => 1000, "where" => Dict("stakedTokens_gte" => "100000000000000000000000")
    )
    f = ["id", "delegatedTokens", "stakedTokens", "lockedTokens"]
    return v, a, f
end

"""
    aquery()

Return the components of a GraphQL query for allocations.

For use with the TheGraphData.jl package.

```julia
julia> using AllocationOpt
julia> value, args, fields = AllocationOpt.aquery()
```

# Extended Help
You can find TheGraphData.jl at https://github.com/semiotic-ai/TheGraphData.jl
"""
function aquery()
    v = "allocations"
    a = Dict{String,Union{Dict{String,String},String}}(
        "where" => Dict("status" => "Active")
    )
    f = ["allocatedTokens", "subgraphDeployment{ipfsHash}", "indexer{id}"]
    return v, a, f
end

"""
    nquery()

Return the components of a GraphQL query for network parameters.

For use with the TheGraphData.jl package.

```julia
julia> using AllocationOpt
julia> value, args, fields = AllocationOpt.nquery()
```

# Extended Help
You can find TheGraphData.jl at https://github.com/semiotic-ai/TheGraphData.jl
"""
function nquery()
    v = "graphNetwork"
    a = Dict("id" => 1)
    f = [
        "id",
        "totalSupply",
        "networkGRTIssuance",
        "epochLength",
        "totalTokensSignalled",
        "currentEpoch",
    ]
    return v, a, f
end

"""
    savenames(p::AbstractString)

Return a generator of the generic names of the CSV files containing the data with the
path specified by `p`.

```julia
julia> using AllocationOpt
julia> path = "mypath"
julia> paths = AllocationOpt.path(path)
```
"""
function savenames(p::AbstractString)
    return Base.Generator(
        x -> joinpath(p, x),
        ("indexer.csv", "allocation.csv", "subgraph.csv", "network.csv"),
    )
end

"""
    data(f::AbstractString, config::AbstractDict)

Read the CSV files from `f` and return the tables from those files.

```julia
julia> using AllocationOpt
julia> i, a, s, n = AllocationOpt.data("myreaddir", config("verbose" => true))
```
"""
function data(f::AbstractString, config::AbstractDict)
    d = FlexTable[]
    for p in savenames(f)
        config["verbose"] && @info "Reading data from $p"
        push!(d, flextable(@mock(TheGraphData.read(p))))
    end
    i, a, s, n = d
    return i, a, s, n
end
