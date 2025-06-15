module MAPElites

export GridArchive, select_random, select_best_elite, select_worst_elite
export find_niche, select_best_elite, select_worst_elite, select_random
export AbstractArchive, BehaviorDescriptorStrategy, FitnessStrategy, VariationStrategy

include("interface.jl")
include("archives/grid_archive.jl")

end
