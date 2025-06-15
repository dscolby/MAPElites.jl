using MAPElites
using Test
using Aqua
using JET

include("test_archives/test_archive.jl")

@testset "Code Quality (Aqua.jl)" begin
    Aqua.test_all(MAPElites)
end

@testset "Code Linting (JET.jl)" begin
    JET.test_package(MAPElites; target_defined_modules=true)
end
