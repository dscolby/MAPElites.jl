# MAPElites.jl

# Structs

# Functions

# Macros

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
code follows the guidelines below.

*   Before being merged, all pull requests should be well tested and all tests must be passing.

*   All abstract types, structs, functions, methods, macros, and constants have docstrings 
    that follow the same format as the other docstrings. These functions should also be 
    included in the relevant section above.

*   There are no repeated code blocks. If there are repeated codeblocks, then they should be 
    consolidated into a separate function.

*   Interanl methods can contain types and be parametric but public methods should be as 
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

