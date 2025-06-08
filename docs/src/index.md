```@raw html
<div style="text-align: center; padding: 1rem;">
            <a class="github-button"
               href="https://github.com/dscolby/MAPElites.jl"
               data-icon="octicon-star"
               data-size="large"
               data-show-count="true"
               aria-label="Star dscolby/MAPElites.jl on GitHub">
               Star
            </a>
            <script async defer src="https://buttons.github.io/buttons.js"></script>
        </div>
```

```@meta
CurrentModule = MAPElites
```

# Motivation
Most optimization algorithms search for a single best solution, but this can be suboptimal for
various reasons. First, many optimizers get stuck in a local min/maximum searching for a single best
solution. Second, a lot of optimizers are unable to balance exploration and exploitation, which
can lead them to overlook promising solutions or even get stuck in local optima. Third, almost all 
optimization algorithms are not ammenable to understanding the relationship between features and 
performance — they are bascially just black boxes. And finally, and arguably the biggest motivation, 
is that traditional optimization seeks a single best solution for a given situation. However, what 
works well in one situation might not be the best solution for another. Quality-diversity algorithms
address these shortcomings by searching for a diverse set of high performing solutions, rather 
than a single solution. One of the most successful and widely used quality-diversity algorithms 
is Multi-dimensional Archive of Phenotypic Elites (MAP-Elites), which can be categorized as an 
evolutionary algorithm. MAP-Elites uses genetic operators to evolve high quality candidate solutions 
at each point within a discretized behavior (feature) space, which the user can choose.[^1]

# Package 
*   Simplicity at its core: MAPElites.jl is designed to be simple and easy to use. Therefore, it 
    contains implementations for a diverse but small core set of variants of MAP-Elites to cover a 
    variety of situations without requiring hard-to-understand abstractions.

*   Customizable: MAPElites.jl lets you use whatever behavior descriptors or fitness functions you 
    want. You can use any function as a fitness function as long as it returns a real number. This 
    also makes it easy to mix and match genetic operators, behavior descriptions, and fitness functions, 
    or write your own.

*   Library-agnostic: Unlike some Python implementations of quality-diversity algorithms, MAPElites.jl
    't require you to use any specific library for arrays or tensors. You are free to use base 
    Julia, CUDA arrays from CUDA.jl, or any other library. As long as your fitness function can 
    evaluate your candidate solutions, you can use whatever data structure you want, be it arrays, 
    strings, images, or anything else.

*   Works with Optimization.jl: The implementations in MAPElites.jl can also be called from within
    Optimization.jl (coming soon).

# Alternatives
There are a few alternatives to MAPElites.jl for quality-diversity algorithms written in Python.
*   QDax: A Jax-based implementation of several quality-diversity algorithms mostly designed around 
    reinforcement learning and robotics.

*   PyRibs: A barebones Python implementation that uses an ask-tell interface that also focuses on 
    reinforcement learning.

*   qdpy: A generic minimal implementation of quality-diversity algroithms in Python.

*   CVT-MAP-Elites: A simple Python implementation of CVT-MAP-Elites.

# Contents
```@contents
```

# Index
```@index
```

```@autodocs
Modules = [MAPElites]
```

# References
[^1]: Mouret, Jean-Baptiste, and Jeff Clune. "Illuminating search spaces by mapping elites." arXiv preprint arXiv:1504.04909 (2015).
