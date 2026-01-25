"""
These are all methods that must be implemented to extend initializers, archives, behavior 
    strategies, selection functions, variation strategies, and fitness strategies. Any of 
    the relevant structures that implement this interface can be used in a MAPElites struct.
"""

"""
An abstract type that all archives must be subtypes of. All subtypes must implement the 
    find_niche, Base.setindex!, select_random, select_best_elite, and 
    select_worst_elite methods.
"""
abstract type AbstractArchive end

"""
An abstract type that all variation strategies must be subtypes of. Concrete variation 
    strategies can store any state information such as iterations or hyperparameters and 
    must implement the vary method.
"""
abstract type VariationStrategy end

"""
An abstract type that all fitness strategies must be subtypes of. Concrete fitness 
    strategies can store state information such as iterations, hyperparemeters, or other 
    data structures. For example, a fitness strategy could store a surrogate model to avoid 
    evaluating a costly fitness function at every iteration. All subtypes must implement a 
    fitness method.
"""
abstract type FitnessStrategy end

"""
An abstract type that all concrete behavior descriptor strategies must be subtypes of.
    In its simplest form, a behavior descriptor strategy can just return the original 
    behavior descriptor vector it is passed. However, a behavioral descriptor strategy could 
    also store state information or dimensionality reduction methods, for example. All 
    subtypes must implement a describe_behavior method.
"""
abstract type BehaviorDescriptorStrategy end

"""
Find the index of the archive for the corresponding behavior descriptor.

This method must be implemented for all subtypes of AbstractArchive. When implementing a new 
    find_niche method on a subtype of AbstractArchive, the method must return a tuple 
    corresponding to the index in the archive.
"""
function find_niche(a::AbstractArchive, bd::BehaviorDescriptorStrategy) end

"""
Get the solution, behavior descriptor, and fitness at the given index.
"""
# function Base.getindex end

"""
Set the index of an archive.

All subtypes of AbstractArchive must implement this method.
"""
# function Base.setindex! end

"""
Get a random solution and its corresponding behavior descriptor and fitness from an archive.

This method may optionally be extened to new subtypes of AbstractArchive. When implementing 
    a new select_random method on a subtype of AbstractArchive, the method must return a 
    tuple of solution, behavior descriptor, fitness.
"""
function select_random(a::AbstractArchive) end

"""
Get the best performing solution and its corresponding behavior descriptor and fitness from 
an archive.

This method may optionally be extended to new subtypes of AbstractArchive. When implementing 
    a new select_best_elite method on a subtype of AbstractArchive, the method must 
    return a tuple of soltuion, behavior descriptor, fitness.
"""
function select_best_elite(a::AbstractArchive) end

"""
Get the worst performing solution and its corresponding behavior descriptor and fitness from 
an archive.

This method may optionally be extended to subtypes of AbstractArchive. When implementing a 
    new select_worst_elite method on a subtype of AbstractArchive, the method must return 
    a tuple of soltuion, behavior descriptor, fitness.
"""
function select_worst_elite(a::AbstractArchive) end

"""
    Base.getindex(a, key...)

Get a tuple of the solution, behavior_descriptor, and fitness of the corresponding index.

# Arguments
- `a::AbstractArchive`: A subtype of AbstractArchive to retrive the data from.
- `key...::Tuple`: A tuple corresponding to the index to retrieve data from.

# Returns
- `Tuple`: The solution, it's behavior descriptor, and fitness.

# Examples
```jldoctest
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> idx = 2, 1
julia> g[idx...]
(nothing, nothing, nothing)
```

```jldoctest
julia> dims, lb, ub = (3, 4), (0, -1), (1, 2)
julia> c = CVTArchive(dims, lb, ub)
julia> idx = 2
julia> c[idx...]
(nothing, nothing, nothing)
```
"""
function Base.getindex(a::A, key...) where A <: AbstractArchive
    return a.solutions[key...], a.behaviors[key...], a.fitnesses[key...]
end

"""
    Base.setindex!(a, value, key...)

Set the solution, behavior_descriptor, and fitness of the corresponding index in an 
    AbstractArchive.

# Arguments
- `a::AbstractArchive`: A GridArchive to retrive the data from.
- `value::Tuple{Any, AbstractVector{<:Real}, <Real}`: The solution, behavior descriptor, and 
    fitness function to assign to the key.
- `key...::Tuple`: A tuple corresponding to the index to retrieve data from.

# Examples
```jldoctest
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> idx = 2, 1
julia> g[idx...] = (90, [1.0, 2.0], 3.0)
julia> g[idx...]
(90, [1.0, 2.0], 3.0)
```
"""
function Base.setindex!(a::A, value, key...) where A <: AbstractArchive
    a.solutions[key...] = value[1]
    a.behaviors[key...] = value[2]
    a.fitnesses[key...] = value[3]

    if isnothing(a.best_elite_idx) || a.fitnesses[a.best_elite_idx] < value[3]
        a.best_elite_idx = key
    end

    if isnothing(a.worst_elite_idx) || a.fitnesses[a.best_worst_idx] > value[3]
        a.worst_elite_idx = key
    end
end

"""
    select_random(a)

Get a random solution, its behavior descriptor, and fitness.

# Arguments
- `a::AbstractArchive`: An AbstractArchive to retrive the solution from.

# Examples
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_random(g)
[1.0, 2.0]
```
```julia
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> c = CVTArchive(dims, lb, ub)
julia> select_random(c)
[1.0, 2.0]
```
"""
function select_random(a::A) where A <: AbstractArchive
    idx = rand(CartesianIndices(a.solutions))
    return a.solutions[idx], a.behaviors[idx], a.fitnesses[idx]
end

"""
    select_best_elite(a)

Get a the best solution, its behavior descriptor, and fitness.

This method assumes the best solution has the highest fitness.

# Arguments
- `a::AbstractArchive`: An AbstractArchive to retrive the solution from.

# Examples
```jldoctest
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_best_elite(g)
[1.0, 2.0]
```
"""
function select_best_elite(a::A) where A <: AbstractArchive
    idx = a.best_elite_idx
    idx isa NTuple || throw(UndefRefError())

    return (
        a.solutions[idx...],
        a.behaviors[idx...],
        a.fitnesses[idx...]
    )
end

"""
    select_worst_elite(a)

Get the worst solution, its behavior descriptor, and fitness.

This method assumes the worst solution has the lowest fitness.

# Arguments
- `a::AbstractArchive`: An AbstractArchive to retrive the solution from.

# Examples
```jldoctest
julia> dims, lb, ub = (5,), (0.0,), (10.0,)
julia> g = GridArchive(dims, lb, ub)
julia> select_worst_elite(g)
[1.0, 2.0]
```
"""
function select_worst_elite(a::AbstractArchive)
    idx = a.worst_elite_idx
    idx isa NTuple || throw(UndefRefError())

    return (
        a.solutions[idx...],
        a.behaviors[idx...],
        a.fitnesses[idx...]
    )
end
