# Installation
From the Julia REPL, type ] to enter the Pkg REPL mode and run
```julia
pkg> add MAPElites
```

# Usage

## Standard Workflow

## Using with Optimizers.jl

# Algorihtms

## MAP-Elites
MAP Elites initializes a discretized behavior grid with random solutions, then uses genetic 
operators to improve the solutions in each grid cell. This results in an archive of diverse, 
high-performing solutions.[^1]

## CVT-MAP-Elites
Central Voronoi tesselation MAP-Elites (CVT-MAP-Elites) replaces fixed grid cells with a fixed 
number of Voronoi tesselations to scale MAP-Elites to higher dimensional behavior spaces.[^2]

## AURORA
AUtonomous RObots that Realize their Abilities (AURORA) extends MAP-Elites to high-dimensional 
or complicated behavior spaces by using unsupervised learning methods to project behavioral 
descriptors into a lower dimensional latent space and store them in an adaptively sized archive.[^3] 
The implementation in MAPElites.jl uses principal component analysis as the dimensionality reduction 
technique, which tended to perform better than an autoencoder in experiments in the original paper.

## SAIL
Surrogate assisted illumination (SAIL) combines MAP-Elites with a Gaussian process regression (GP) 
to reduce sample complexity. After initially filling a behavioral archive, SAIL trains a on the
archive to predict the objective function. Then, SAIL uses another archive, the acquisition archive, 
to run UCB on the initial solutions, replacing the objective function with an upper confidence bound 
estimate from the GP. Then, k solutions are sampled from the acquisition archive and evaluated on the
objectie function. If they perform better than the solution in corresponding cell of the behavioral 
archive, then they replace that behavior. The process then repeats for a fixed number of iterations.[^4]

## CMA-MAP-Elites
Covariance Matrix Adaptation MAP-Elites (CMA MAP-Elites) improves the sample efficiency of the 
original MAP-Elites algorithm by replacing the crossover and mutation operators with covariance 
matrix adaptation.[^5]


[^1]: Mouret, Jean-Baptiste, and Jeff Clune. "Illuminating search spaces by mapping elites." arXiv preprint arXiv:1504.04909 (2015).
[^2]: Vassiliades, Vassilis, Konstantinos Chatzilygeroudis, and Jean-Baptiste Mouret. "Using centroidal voronoi tessellations to scale up the multidimensional archive of phenotypic elites algorithm." IEEE Transactions on Evolutionary Computation 22, no. 4 (2017): 623-630.
[^3]: Cully, Antoine. "Autonomous skill discovery with quality-diversity and unsupervised descriptors." In Proceedings of the Genetic and Evolutionary Computation Conference, pp. 81-89. 2019.
[^4]: Gaier, Adam, Alexander Asteroth, and Jean-Baptiste Mouret. "Data-efficient exploration, optimization, and modeling of diverse designs through surrogate-assisted illumination." In Proceedings of the Genetic and Evolutionary Computation Conference, pp. 99-106. 2017.
[^5]: Fontaine, Matthew C., Julian Togelius, Stefanos Nikolaidis, and Amy K. Hoover. "Covariance matrix adaptation for the rapid illumination of behavior space." In Proceedings of the 2020 genetic and evolutionary computation conference, pp. 94-102. 2020.
