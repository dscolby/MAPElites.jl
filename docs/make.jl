using MAPElites
using Documenter

DocMeta.setdocmeta!(MAPElites, :DocTestSetup, :(using MAPElites); recursive=true)

makedocs(;
    modules=[MAPElites],
    repo="https://github.com/dscolby/MAPElites.jl/blob/{commit}{path}#{line}",
    authors="Darren Colby and contributors",
    prettyurls=get(ENV, "CI", "false") == "true",
    sitename="MAPElites.jl",
    format=Documenter.HTML(;
        canonical="https://dscolby.github.io/MAPElites.jl/stable",
        edit_link="main",
        sidebar_sitename=false,
        footer="© 2025 Darren Colby",
        assets=[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dscolby/MAPElites.jl",
    devbranch="dev",
)
