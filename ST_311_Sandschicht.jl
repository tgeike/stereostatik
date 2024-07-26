### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 497aa4fa-5dd6-4001-b51f-78dee58d2b7b
using Unitful

# ╔═╡ 63047770-4b24-11ef-0ba8-352b6e5d074c
md"""
# Technische Berechnungen mit Julia
## Masse und Gewichtskraft einer Sandschicht"""

# ╔═╡ 5d0b7973-48b9-469c-a257-f9db40000dd1
A = 50.0u"m"*50.0u"m"

# ╔═╡ 78982066-b1f5-4bf3-83fd-1fde7dbb8b6f
h = 20.0u"cm"

# ╔═╡ dbe7bb5c-3c2e-415d-af88-f400435c7275
V = A*h |> u"m^3"

# ╔═╡ 50388457-d775-4d72-8554-ef0180435222
ρ = 1600.0u"kg/m^3"

# ╔═╡ 955e08fc-593d-45d7-b15e-b92fd6cf8b0c
m = ρ*V

# ╔═╡ ce8624a1-1cbf-4e57-9b70-2d8d737a13f7
g = 9.81u"m/s^2"

# ╔═╡ 209f079e-40a0-426e-8c96-99d1cb543df2
FG = m*g |> u"kN"

# ╔═╡ 52fcab8f-1935-4012-86b0-372a3f88fad9
FG/A

# ╔═╡ 2b94692a-b8ad-41f0-99ef-e4df804ffb2e
md"""Die Gesamtmasse des Sandes beträgt $(m), das sind $(ustrip(u"kg",m)/1000) Tonnen. Die Gewichtskraft beträgt $(FG). Wenn man die Gewichtskraft auf die Fläche bezieht, ergibt sich eine Kraftdichte von $(FG/A)."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
Unitful = "~1.20.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "1f2a9460315a5a9ad0dbcf447ee8fe9a7d6288ff"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "dd260903fdabea27d9b6021689b3cd5401a57748"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.20.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─63047770-4b24-11ef-0ba8-352b6e5d074c
# ╠═497aa4fa-5dd6-4001-b51f-78dee58d2b7b
# ╠═5d0b7973-48b9-469c-a257-f9db40000dd1
# ╠═78982066-b1f5-4bf3-83fd-1fde7dbb8b6f
# ╠═dbe7bb5c-3c2e-415d-af88-f400435c7275
# ╠═50388457-d775-4d72-8554-ef0180435222
# ╠═955e08fc-593d-45d7-b15e-b92fd6cf8b0c
# ╠═ce8624a1-1cbf-4e57-9b70-2d8d737a13f7
# ╠═209f079e-40a0-426e-8c96-99d1cb543df2
# ╠═52fcab8f-1935-4012-86b0-372a3f88fad9
# ╟─2b94692a-b8ad-41f0-99ef-e4df804ffb2e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
