# MAPElites.jl

# MAPElites.jl APIs
MAPElites.jl maximizes modularity and extensibility by using a strategy design pattern. A full
MAPElites container takes a variation strategy for mutating candidate solutions, a fitness 
strategy for evaluating candidate fitness, and a behavior descriptor strategy for calculating
behavior descriptors for candidate solutions. Each solution, along with its behavior descriptor, 
and fitness are stored in an archive, which is a subtype of an AbstractArchive. These components
are explained more below.

## AbstractArchive
The MAPElites struct expects an archive that implements the AbstractArchive API to store solutions. 
All subtypes of AbstractArchive must implement the find_niche and Base.setindex! functions. 
The find_niche method must take as inputs a concrete archive and a behavior descriptor vector
and return an index in the archive that corresponds to the given behavior descriptor. The setindex! 
method must set or update the given index in the archive with the given solution, behavior descriptor, 
and fitness. Optionally, a subtype of AbstractArchive may also include select_random, select_best_elite, 
and select_worst_elite methods that return a tuple containing a solution, behavior descriptor, and 
fitness that is either random, the best solution, or the worst solution. In any case, all concrete 
archives must have at least one method to retrieve an elite, and select_random, select_best_elite, 
and select_worst_elite are suggested methods.

## VariationStrategy
Running MAP-Elites or a variant requires some way to create child solutions by mutating or changing 
parent solutions. In MAPElites.jl, this is a variation strategy that is a subtype of the 
VariationStrategy abstract type. A concrete variation strategy can contain arbitrary fields, e.g. 
to keep track of the iteration or parameters for a normal distribution. Additionally, a concrete 
variation strategy must have an associated functor that accepts a candidate solution and returns
a new candidate solution.

## FitnessStrategy
Running MAP-Elites also requires some way to evaluate the fitness of candidate solutions, which is 
accomplished by using a fitness strategy. Fitness strategies must be subtypes of the FitnessStrategy 
abstract type. Concrete fitness strategies may have any arbitraryi fields. For example, a fitness 
strategy may include a surrogate model such as a Gaussian process regression to avoid computing 
an expensive fitness function at every iteration. Like variation strategies, fitness strategies must
implement a functor that accepts a candidate solution as an argument and returns a concrete subbtype 
of Real.

## BehaviorDescriptorStrategy
A key ingredient of MAP-Elites and its variants is a behavior descriptor. In MAPElites.jl, this 
takes the form of behavior descriptor strategies. All concrete behavior descriptor strategies must
be subtypes of the BehaviorDescriptorStrategy abstract type and implement a functor that takes in 
a raw behavior descriptor and outputs a behavior descriptor vector. Like other strategies, subtypes 
can store arbitrary information and can be as simple as returning the behavior descriptor that is 
passed as an argument or as complicated as using a dimensionality reduction technique like a VAE.

# Modules
```@docs
MAPElites
```

# Abstract Types
```@docs
AbstractArchive
VariationStrategy
FitnessStrategy
BehaviorDescriptorStrategy
```

# Structs
```@docs
Algorithm
GridArchive
```

# Functions
```@docs
find_niche
Base.getindex
Base.setindex!
select_random
select_best_elite
select_worst_elite
```

# Contributing
All contributions are welcome. To ensure contributions align with the existing code base and 
are not duplicated, please follow the guidelines below.

## Reporting a Bug
To report a bug, open an issue on GitHub [page](https://github.com/dscolby/MAPElites.jl/issues). 
Please include all relevant information, such as what methods were called, the operating system used, 
the verion/s of MAPElites.jl used, the verion/s of Julia used, any tracebacks or error codes, and 
any other information that would be helpful for debugging. Also be sure to use the bug label.

## Requesting New Features
Before requesting a new feature, please check the issues page on [GitHub](https://github.com/dscolby/MAPElites.jl/issues) 
to make sure someone else did not already request the same feature. If this is not the case, then 
please open an issue that explains what function or method you would like to be added and how you 
believe it should behave. Also be sure to use the enhancement tag.

## Contributing Code
Before submitting a [pull request](https://github.com/dscolby/MAPElites.jl/pulls), please 
open an issue explaining what the proposed code is and why you want to add it, if there is 
not already an issue that addresses your changes and you are not fixing something very 
minor. When submitting a pull request, please reference the relevant issue/s and ensure your 
code follows the guidelines below. Please also see above for an overview of how this package 
and its components are designed.

*   Before being merged, all pull requests should be well tested and all tests must be passing.

*   All abstract types, structs, functions, methods, macros, and constants have docstrings 
    that follow the same format as the other docstrings. These functions should also be 
    included in the relevant section above.

*   There are no repeated code blocks. If there are repeated codeblocks, then they should be 
    consolidated into a separate function.

*   Internal methods can contain types and be parametric but public methods should be as 
    general as possible.

*   Minimize use of new constants and macros. If they must be included, the reason for their 
    inclusion should be obvious or included in the docstring.

*   In most cases, avoid using global variables and constants.

*   Code should take advantage of Julia's built in macros for performance. Use @inbounds, 
    @view, @fastmath, and @simd when possible.

*   When appending to an array in a loop, preallocate the array and update its values by 
    index.

*   Avoid long functions and decompose them into smaller functions or methods. A general 
    rule is that function definitions should fit on your screen.

*   Use self-explanatory names for variables, methods, structs, constants, and macros.

*   Make generous use of whitespace.

*   All functions should include docstrings.

!!! note
    MAPElites.jl follows the Blue style guide and all code is automatically formatted to 
    conform with this standard upon being pushed to GitHub.

## Updating or Fixing Documentation
To propose a change to the documentation please submit an [issue](https://github.com/dscolby/MAPElites.jl/issues) 
or [pull request](https://github.com/dscolby/MAPElites.jl/pulls).

