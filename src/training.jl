using Random

mutable struct MAPElites{
    A <: AbstractArchive, V <: AbstractVariationStrategy, F <: AbstractFitnessStrategy
} <: AbstractRunner
    archive::A
    selector::Function
    variaton_strategy::V
    fitness_strategy::F
    behavior_descriptor_strategy::B
    initializer::Function  # Expects RNG as parameter to be thread-safe
    k::Int
    iterations::Int
end

function _init(me::MAPElites)
     for i in 1:me.k
        rng = Random.default_rng()
        candidate = me.initializer(rng)
        behavior = behavior_descriptor(me.behavior_descriptor_strategy, candidate)
        fit_score = fitness(me.fitness_strategy, candidate)
        idx = find_niche(me.archive, elite)
        me.archive.solutions[idx...] = candidate
        me.archive.behaviors[idx...] = behavior
        me.archive.fitnesses[idx...] = fit_score
    end
end

function _run(me::MAPElites)
    _init(me)

    for i in 1:me.iterations
        println(
            "Iteration " * string(i) * " of " * string(me.iterations) * 
            " with minimum fitness of " * string(worst_elite_selection(me.archive)) 
            * " and maximum fitness of " * string(best_elite_selection(me.archive))
        )
        par_sol, par_beh, par_fit = me.selector(me.archive)

        # Ensures there will be an actual solution and nt just nothing when not all the
        # cells have been filled yet
        while isnothing(parent)
            parent = me.selector(me.archive)
        end

        child = vary(me.variaton_strategy, parent)
        child_fitness = fitness(me.fitness_strategy, child)

        if child_fitness > parent.fitness
            bd = behavior_descriptor(me.behavior_descriptor_strategy, child)
            elite_child = Elite(child, bd, child_fitness)
            idx = find_rival(me.archive, elite_child)
            me.archive[idx...] = child_elite
        end
    end
end
