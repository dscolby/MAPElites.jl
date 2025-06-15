using Test
using MAPElites
using Random

@testset "GridArchive constructor and initial state" begin
    dims, lb, ub = (3, 4), (0.0, -1.0), (1.0, 2.0)
    g = GridArchive(dims, lb, ub)
    @test g isa GridArchive
    @test g.dims == dims
    @test g.lb == lb
    @test g.ub == ub
    @test size(g.solutions) == dims
    @test size(g.behaviors) == dims
    @test size(g.fitnesses) == dims
    @test all(x -> x === nothing, g.solutions)
    @test all(x -> x === nothing, g.behaviors)
    @test all(x -> x === nothing, g.fitnesses)
    @test isnothing(g.best_elite_idx)
    @test isnothing(g.worst_elite_idx)
end

@testset "find_niche 1D behavior" begin
    dims, lb, ub = (5,), (0.0,), (10.0,)
    g = GridArchive(dims, lb, ub)

    # Lower bound:
    idx = MAPElites.find_niche(g, [0.0])
    @test idx == (1,)

    # Upper bound:
    idx = MAPElites.find_niche(g, [10.0])
    @test idx == (5,)

    # Mid point 5.0: (5/10)*(5-1)=2.0 → floor 2 +1 = 3
    idx = MAPElites.find_niche(g, [5.0])
    @test idx == (3,)

    # Below lower bound:
    idx = MAPElites.find_niche(g, [-1.0])
    @test idx == (1,)

    # Above upper bound:
    idx = MAPElites.find_niche(g, [20.0])
    @test idx == (5,)
end

@testset "find_niche multi-dimensional" begin
    dims, lb, ub = (4, 3), (0.0, 0.0), (1.0, 2.0)
    g = GridArchive(dims, lb, ub)

    # Corners:
    @test MAPElites.find_niche(g, [0.0, 0.0]) == (1, 1)
    @test MAPElites.find_niche(g, [1.0, 2.0]) == (4, 3)

    # Mid values:
    # Dimension 1: 0.5 → frac=0.5; floor(0.5*(4-1)=1.5)+1=2
    # Dimension 2: 1.0 → frac=1/2=0.5; floor(0.5*(3-1)=1)+1=2
    @test MAPElites.find_niche(g, [0.5, 1.0]) == (2, 2)

    # Out-of-bounds for clamping behavior
    @test MAPElites.find_niche(g, [-10.0, 5.0]) == (1, 3)
end

@testset "find_niche length mismatch errors" begin
    dims, lb, ub = (2, 2), (0.0, 0.0), (1.0, 1.0)
    g = GridArchive(dims, lb, ub)
    g.behaviors[1, 1] = [1, 2, 3, 4]

    # Expect ArgumentError due to length mismatch
    @test_throws ArgumentError MAPElites.find_niche(g, [0.1])  
    @test_throws ArgumentError MAPElites.find_niche(g, [0.1, 0.2, 0.3])
end

@testset "Indexing with getindex/setindex!" begin
    dims, lb, ub = (2, 2), (0.0, 0.0), (1.0, 1.0)
    g = GridArchive(dims, lb, ub)

    idx = 2, 1
    @test g[idx...] == (nothing, nothing, nothing)
    g[idx...] = (90, [1.0, 2.0], 3.0)
    @test g[idx...] == (90, [1.0, 2.0], 3.0)
    
    # Ensure other cells still nothing
    other_idx = 1, 1
    @test g[other_idx...] == (nothing, nothing, nothing)
end

@testset "Selecting Best, Worst, and Random Solutions" begin
    dims, lb, ub = (2, 2), (0.0, 0.0), (1.0, 1.0)
    g = GridArchive(dims, lb, ub)
    idx = 2, 1
    g[idx...] = (90, [1.0, 2.0], 3.0)

    @test select_random(g) isa Tuple
    @test select_best_elite(g) == (90, [1.0, 2.0], 3.0)
    @test select_worst_elite(g) == (90, [1.0, 2.0], 3.0)
end
