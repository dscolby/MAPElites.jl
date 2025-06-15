"""
MAPElites contains implementations of the MAP-Elites, CVT-MAP-Elites, AURORA, SAIL, and 
CMA-MAP-Elites as well as archives, fitness strategies and functors, behavior descriptor 
strategies and functors, variation operators, and selection operators that can be mixed and 
matched.

For more information on MAP-Elites, see:
    Mouret, Jean-Baptiste, and Jeff Clune. "Illuminating search spaces by mapping elites." 
    arXiv preprint arXiv:1504.04909 (2015).
"""
module MAPElites

export Algorithm
export GridArchive, select_random, select_best_elite, select_worst_elite
export find_niche, select_best_elite, select_worst_elite, select_random
export AbstractArchive, BehaviorDescriptorStrategy, FitnessStrategy, VariationStrategy

include("interface.jl")
include("archives/grid_archive.jl")
include("training.jl")

end
