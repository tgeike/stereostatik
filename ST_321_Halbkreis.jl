### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 0102ef1d-d570-43b5-b2b6-76fc4bcc8750
using QuadGK

# ╔═╡ 433be8d8-482a-11ef-3e42-73c91a3ef61c
md"""
## Aufgabe 3
Die Aufgabenstellung findet sich im Abschnitt 3.3."""

# ╔═╡ 4664be97-43dd-41a1-b76d-93e4fb3c719d
md"""
Der Halbkreis wird im betrachteten Koordinatensystem durch die Funktion ``y(x) = \sqrt{r^2 - x^2}`` beschrieben.

Die Fläche ``A`` des Halbkreises berechnet sich zu
```math
A = \int_{-r}^{r} y\, \mathrm{d}x = r^2  \int_{-1}^{1} \sqrt{1-\xi^2}\; \mathrm{d}\xi\,,
```
wobei die Substitution ``x = r\,\xi`` benutzt wurde.

Im konkreten Anwednungsfall mit gegebenem Radius ``r`` ist diese Substitution nicht notwendig. Dann würde man direkt die gegebene Funktion ``y(x)`` integrieren. Wir wollen hier eine allgemeine Formel in Abhängigkeit vom Radius ``r`` erzeugen. Nur dafür ist die Substitution notwendig.
"""

# ╔═╡ 0390d26e-a22a-4814-a748-9251db07869f
f1(ξ) = sqrt(1-ξ^2)

# ╔═╡ 7d41d326-2f7a-4405-a818-8b82f9f4eaf7
integral1,fehler1 = quadgk(f1,-1,1)

# ╔═╡ 6d9a5246-21cd-4425-911b-702e59541ea1
integral1/π

# ╔═╡ a506c342-feb8-42d3-8158-dbc610a4d93e
md"""Für die Fläche des Halbkreises erhält man das bekannte Ergebnis: ``A = (\pi/2)\, r^2``."""

# ╔═╡ 27aeee02-d717-46ed-b746-58e2186e45b3
md"""Für den Flächenschwerpunkt gilt ``x_\mathrm{S} = 0`` und
```math
y_\mathrm{S} = \frac{\int_{-r}^{r} \frac{1}{2}y^2\, \mathrm{d}x}{\int_{-r}^{r} y\, \mathrm{d}x} = \frac{1}{2}r\, \frac{\int_{-1}^{1} 1-\xi^2 \; \mathrm{d}\xi}{\int_{-1}^{1} \sqrt{1-\xi^2}\; \mathrm{d}\xi}\;.
```
Das Integral im Nenner haben wir bereits ausgewertet. Das Integral im Zähler folgt nun."""

# ╔═╡ e985adf2-00a5-4e74-9226-e73ec4d9309c
f2(ξ) = 1 - ξ^2

# ╔═╡ 0db3fa6f-21af-439c-a1df-1d9082655743
integral2,fehler2 = quadgk(f2,-1,1)

# ╔═╡ 02b68c45-5c90-47f5-a112-04f2be2cf754
md"""Für den Flächenschwerpunkt des Halbkreises ergibt sich ebenfalls das bekannte Ergebnis
```math
y_\mathrm{S} = \frac{4}{3\pi}r \;,
```
also ``y_\mathrm{S}\approx`` $(round(integral2/π,digits=3))``r``."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
QuadGK = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"

[compat]
QuadGK = "~2.9.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "33c3c52ac970924126a38ff9e6c8952b52b4eaa2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─433be8d8-482a-11ef-3e42-73c91a3ef61c
# ╠═0102ef1d-d570-43b5-b2b6-76fc4bcc8750
# ╟─4664be97-43dd-41a1-b76d-93e4fb3c719d
# ╠═0390d26e-a22a-4814-a748-9251db07869f
# ╠═7d41d326-2f7a-4405-a818-8b82f9f4eaf7
# ╠═6d9a5246-21cd-4425-911b-702e59541ea1
# ╟─a506c342-feb8-42d3-8158-dbc610a4d93e
# ╟─27aeee02-d717-46ed-b746-58e2186e45b3
# ╠═e985adf2-00a5-4e74-9226-e73ec4d9309c
# ╠═0db3fa6f-21af-439c-a1df-1d9082655743
# ╟─02b68c45-5c90-47f5-a112-04f2be2cf754
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
