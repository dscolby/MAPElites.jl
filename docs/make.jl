using MAPElites
using Documenter

DocMeta.setdocmeta!(MAPElites, :DocTestSetup, :(using MAPElites); recursive=true)

makedocs(;
    modules=[MAPElites],
    authors="Darren Colby and contributors",
    sitename="MAPElites.jl",
    format=Documenter.HTML(;
        canonical="https://dscolby.github.io/MAPElites.jl",
        edit_link="main",
        sidebar_sitename=false,
        footer="© 2024 Darren Colby",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dscolby/MAPElites.jl",
    devbranch="dev",
)
