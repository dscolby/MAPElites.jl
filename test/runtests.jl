using MAPElites
using Test
using Aqua
using JET

@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(MAPElites)
end

@testset "Code linting (JET.jl)" begin
    JET.test_package(MAPElites; target_defined_modules=true)
end
