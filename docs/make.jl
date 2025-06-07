using MAPElites
using Documenter

DocMeta.setdocmeta!(MAPElites, :DocTestSetup, :(using MAPElites); recursive=true)

makedocs(;
    modules=[MAPElites],
    repo="https://github.com/dscolby/MAPElites.jl/blob/{commit}{path}#{line}",
    authors="Darren Colby and contributors",
    sitename="MAPElites.jl",
    format=Documenter.HTML(;
        canonical="https://dscolby.github.io/MAPElites.jl/stable",
        edit_link="main",
        sidebar_sitename=false,
        html_header=html_header = """
        <div style="text-align: right; padding: 1rem;">
            <a class="github-button"
               href="https://github.com/YourUsername/MyPackage.jl"
               data-icon="octicon-star"
               data-size="large"
               data-show-count="true"
               aria-label="Star YourUsername/MyPackage.jl on GitHub">
               Star
            </a>
            <script async defer src="https://buttons.github.io/buttons.js"></script>
        </div>
        """,
        footer="© 2025 Darren Colby",
        assets=[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(; repo="github.com/dscolby/MAPElites.jl.git")
