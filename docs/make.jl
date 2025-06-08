using MAPElites
using Documenter
using Changelog

DocMeta.setdocmeta!(MAPElites, :DocTestSetup, :(using MAPElites); recursive=true)

Changelog.generate(
  Changelog.Documenter(),
  joinpath(@__DIR__, "../CHANGELOG.md"),
  joinpath(@__DIR__, "src/CHANGELOG.md");
  repo = "dscolby/MAPElites.jl"
)


makedocs(;
    modules=[MAPElites],
    repo="https://github.com/dscolby/MAPElites.jl/blob/{commit}{path}#{line}",
    authors="Darren Colby and contributors",
    sitename="MAPElites.jl",
    format=Documenter.HTML(;
        canonical="https://dscolby.github.io/MAPElites.jl/stable",
        edit_link="main",
        sidebar_sitename=false,
        footer="© 2025 Darren Colby",
        assets=["assets/custom.css"],
    ),
    pages=[
        "Home" => "index.md",
        "Guide" => "guide.md",
        "Developers" => "developers.md",
        "Release Notes" => "CHANGELOG.md"
    ],
)

deploydocs(; repo="github.com/dscolby/MAPElites.jl.git")
