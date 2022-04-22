@testset "optimize.jl" begin
    fake_repository = Repository(
        [
            Indexer(
                "0x000", 5.0, 0.0, [Allocation("0x010", 2.5, 14), Allocation("0x011", 2.5, 14)]
            ),
            Indexer(
                "0x001", 10.0, 0.0, [Allocation("0x010", 2.0, 14), Allocation("0x011", 8.0, 14)]
            ),
        ],
        [Subgraph("0x010", 10.0), Subgraph("0x011", 5.0)],
    )
    @test_throws ArgumentError optimize("0x000", fake_repository, ("0x010",), ("0x010",))

    allocs, _ = optimize("0x000", fake_repository, nothing, nothing)
    @test isapprox(allocs["0x010"], 4.2; atol=0.1)
    @test isapprox(allocs["0x011"], 0.8; atol=0.1)

    allocs, _ = optimize("0x000", fake_repository, nothing, ["0x010"])
    @test allocs["0x011"] ≈ 5.0

    allocs, _ = optimize("0x000", fake_repository, ["0x010"], nothing)
    @test allocs["0x010"] ≈ 5.0

    fake_repository = Repository(
        [
            Indexer(
                "0x000", 2.0, 0.0, [Allocation("0x010", 2.0, 14), Allocation("0x011", 0.0, 14)]
            ),
            Indexer(
                "0x001", 10.0, 0.0, [Allocation("0x010", 10.0, 14), Allocation("0x011", 4.0, 14)]
            ),
        ],
        [Subgraph("0x010", 1.0), Subgraph("0x011", 5.0)],
    )
    allocs, _ = optimize("0x000", fake_repository, nothing, nothing)
    @test allocs["0x010"] ≈ 0.0
    @test allocs["0x011"] ≈ 2.0

    # Test incorporating gas fees, 
    alloc_df = optimize_indexer(;id="0xc60d0c8c74b5d3a33ed51c007ebae682490de261", 
                                grtgas=200.0, alloc_lifetime=14, whitelist=nothing, blacklist=nothing, alloc_lifetime_threshold=20, preference_threshold=1.00)

    # println(alloc_df)
    @test true
end
