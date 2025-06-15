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
function find_niche end

"""
Set the index of an archive.

All subtypes of AbstractArchive must implement this method.
"""
function setindex! end

"""
Get a random solution and its corresponding behavior descriptor and fitness from an archive.

This method may optionally be extened to new subtypes of AbstractArchive. When implementing 
    a new select_random method on a subtype of AbstractArchive, the method must return a 
    tuple of solution, behavior descriptor, fitness.
"""
function select_random end

"""
Get the best performing solution and its corresponding behavior descriptor and fitness from 
an archive.

This method may optionally be extended to new subtypes of AbstractArchive. When implementing 
    a new select_best_elite method on a subtype of AbstractArchive, the method must 
    return a tuple of soltuion, behavior descriptor, fitness.
"""
function select_best_elite end

"""
Get the worst performing solution and its corresponding behavior descriptor and fitness from 
an archive.

This method may optionally be extended to subtypes of AbstractArchive. When implementing a 
    new select_worst_elite method on a subtype of AbstractArchive, the method must return 
    a tuple of soltuion, behavior descriptor, fitness.
"""
function select_worst_elite end
