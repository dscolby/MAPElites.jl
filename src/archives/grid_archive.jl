"""A struct to store solutions and their fitnesses in a discretized behavior grid."""
mutable struct GridArchive{T<:NTuple, U<:NTuple} <: AbstractArchive
    dims::T
    lb::U
    ub::U
    solutions::Array{Any}
    behaviors::Array{Union{AbstractVector{Float64}, Nothing}}
    fitnesses::Array{Union{Nothing, Float64}}
    best_elite_idx::Union{Nothing, NTuple}
    worst_elite_idx::Union{Nothing, NTuple}
end

"""
    GridArchive(dims, lb, ub)

Initialize a grid archive.

# Arguments
- `dims::NTuple`: An NTuple of dimensions for the archive.
- `lb::NTuple`: An NTuple of real numbers where each number is the lower bound for the 
    correspoding axis of the behavior descriptor.
- `ub::NTuple`: An NTuple of real numbers where each number is the upper bound for the 
    correspoding axis of the behavior descriptor.

# Examples
```julia
julia> dims, lb, ub = (3, 4), (0.0, -1.0), (1.0, 2.0)
julia> g = GridArchive(dims, lb, ub)
GridArchive{Tuple{Int64,Int64},Tuple{Float64,Float64}}((3, 4), (0.0, -1.0), (1.0, 2.0)
```
"""
function GridArchive(dims::D, lb::B, ub::B) where {D<:NTuple, B<:NTuple}
        sols = Array{Any}(undef, dims)
        behs = Array{Union{AbstractVector{Float64}, Nothing}}(undef, dims)
        fits = Array{Union{Nothing, Float64}}(undef, dims)
        sols = fill!(sols, nothing)
        behs = fill!(behs, nothing)
        fits = fill!(fits, nothing)
        return GridArchive(dims, lb, ub, sols, behs, fits, nothing, nothing)
end

"""
    find_niche(g, bd)

Get the index of the archive that corresponds to a given behavior descriptor.

# Arguments
- `g::GridArchive`: A GridArchive to get the niche from.
- `bd::AbstractVector{<:Real}`: A real-valued vector representing a behavior descriptor.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> MAPElites.find_niche(g, [0.0])
(1,)
```
"""
function find_niche(g::GridArchive, bd::B) where B <: AbstractVector{<: Real}
    first_behs = findfirst(!isnothing, g.behaviors)

    if !isnothing(first_behs)
        base_bd = g.behaviors[first_behs]
        if length(bd) != length(base_bd)
            throw(
                ArgumentError(
                "bd must have length $(length(base_bd)), got $(length(bd))"
                )
            )
        end
    end

    idx = ntuple(
        i -> begin
            low = g.lb[i]
            high = g.ub[i]
            v = clamp(bd[i], low, high)  # Just in case
            frac = (v - low) / (high - low)
            raw  = floor(Int, frac * (g.dims[i] - 1)) + 1
            clamp.(raw, 1, g.dims[i])
        end, 
        length(bd)
    )
    return idx
end

"""
    Base.getindex(g, key...)

Get a tuple of the solution, behavior_descriptor, and fitness of the corresponding index.

# Arguments
- `g::GridArchive`: A GridArchive to retrive the data from.
- `key...::Tuple`: A tuple corresponding to the index to retrieve data from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> idx = 2, 1
julia> g[idx...]
(nothing, nothing, nothing)
```
"""
function Base.getindex(g::GridArchive, key...)
    return g.solutions[key...], g.behaviors[key...], g.fitnesses[key...]
end

"""
    Base.setindex!(g, value, key...)

Set the solution, behavior_descriptor, and fitness of the corresponding index in a 
    GridArchive.

# Arguments
- `g::GridArchive`: A GridArchive to retrive the data from.
- `value::Tuple{Any, AbstractVector{<:Real}, <Real}`: The solution, behavior descriptor, and 
    fitness function to assign to the key.
- `key...::Tuple`: A tuple corresponding to the index to retrieve data from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> idx = 2, 1
julia> g[idx...] = (90, [1.0, 2.0], 3.0)
julia> g[idx...]
(90, [1.0, 2.0], 3.0)
```
"""
function Base.setindex!(g::GridArchive, value, key...)
    g.solutions[key...] = value[1]
    g.behaviors[key...] = value[2]
    g.fitnesses[key...] = value[3]

    if isnothing(g.best_elite_idx) || g.fitnesses[g.best_elite_idx] < value[3]
        g.best_elite_idx = key
    end

    if isnothing(g.worst_elite_idx) || g.fitnesses[g.best_worst_idx] > value[3]
        g.worst_elite_idx = key
    end
end

"""
    select_random(g)

Get a random solution, its behavior descriptor, and fitness.

# Arguments
- `g::GridArchive`: A GridArchive to retrive the solution from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_random(g)
[1.0, 2.0]
```
"""
function select_random(g::GridArchive)
    idx = rand(CartesianIndices(g.solutions))
    return g.solutions[idx], g.behaviors[idx], g.fitnesses[idx]
end

"""
    select_best_elite(g)

Get a the best solution, its behavior descriptor, and fitness.

This method assumes the best solution has the highest fitness.

# Arguments
- `g::GridArchive`: A GridArchive to retrive the solution from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_worst_elite(g)
[1.0, 2.0]
```
"""
function select_best_elite(g::GridArchive)
    idx = g.best_elite_idx
    idx isa NTuple || throw(UndefRefError())

    return (
        g.solutions[idx...],
        g.behaviors[idx...],
        g.fitnesses[idx...]
    )
end

"""
    select_worst_elite(g)

Get a the worst solution, its behavior descriptor, and fitness.

This method assumes the worst solution has the lowest fitness.

# Arguments
- `g::GridArchive`: A GridArchive to retrive the solution from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_worst_elite(g)
[1.0, 2.0]
```
"""
function select_worst_elite(g::GridArchive)
    idx = g.worst_elite_idx
    idx isa NTuple || throw(UndefRefError())

    return (
        g.solutions[idx...],
        g.behaviors[idx...],
        g.fitnesses[idx...]
    )
end
