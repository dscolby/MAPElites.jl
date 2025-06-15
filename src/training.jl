using Random

"""
    Algorithm(arch, sel, var_strat, fit_strat, bd_strat, init, [, k, iterations])

Initialize an algorithm type to run MAP-Elites or one of its variants.

# Arguments
- `arch::AbstractArchive`: A subtype of AbstractArchive for storing solutions.
- `sel::Function`: A function to select a solution grom the archive.
- `var_strat::VariationStrategy`: A subtype of VariationStrategy to vary or mutate solutions.
- `fit_strat::FitnessStrategy`: A subtype of FitnessStrategy to evaluate solutions.
- `bd_strat::BehaviorDescriptorStrategy`: A subtype of BehaviorDescriptorStrategy to
    generate behavior descriptors.
- `init::Function`: A function that accepts a random number generator and returns a solution
    for initializing the archive.
- `k::Int`=1000: The number of candidates to generate for initialization.
- `iterations::Int=10000`: The number of iterations to run the algorithm for.

# Examples
```julia
julia> dims, lb, ub = (3, 4), (0.0, -1.0), (1.0, 2.0)
julia> g = GridArchive(dims, lb, ub)
julia> sel = select_random()
julia> var_strat = CMA()
julia> init = my_initializer()
julia alg = Algorithm(g, sel, var_strat, init)
```
"""
mutable struct Algorithm{
    A <: AbstractArchive,
    V <: VariationStrategy,
    F <: FitnessStrategy,
    B <: BehaviorDescriptorStrategy
}
    archive::A
    selector::Function
    variaton_strategy::V
    fitness_strategy::F
    behavior_descriptor_strategy::B
    initializer::Function  # Expects RNG as parameter to be thread-safe
    k::Int
    iterations::Int
end

"""
function _init(a::Algorithm)
     for i in 1:a.k
        rng = Random.default_rng()
        candidate = a.initializer(rng)
        behavior = behavior_descriptor(a.behavior_descriptor_strategy, candidate)
        fit_score = fitness(a.fitness_strategy, candidate)
        idx = find_niche(a.archive, elite)
        a.archive.solutions[idx...] = candidate
        a.archive.behaviors[idx...] = behavior
        a.archive.fitnesses[idx...] = fit_score
    end
end

function _run(a::Algorithm)
    _init(a)

    for i in 1:a.iterations
        println(
            "Iteration " * string(i) * " of " * string(a.iterations) * 
            " with minimum fitness of " * string(worst_elite_selection(a.archive)) 
            * " and maximum fitness of " * string(best_elite_selection(a.archive))
        )
        par_sol, par_beh, par_fit = a.selector(a.archive)

        # Ensures there will be an actual solution and nt just nothing when not all the
        # cells have been filled yet
        while isnothing(parent)
            parent = a.selector(a.archive)
        end

        child = vary(a.variaton_strategy, parent)
        child_fitness = fitness(a.fitness_strategy, child)

        if child_fitness > parent.fitness
            bd = behavior_descriptor(a.behavior_descriptor_strategy, child)
            elite_child = Elite(child, bd, child_fitness)
            idx = find_rival(a.archive, elite_child)
            a.archive[idx...] = child_elite
        end
    end
end
"""
