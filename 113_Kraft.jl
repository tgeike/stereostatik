### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ d999c19c-4807-11ef-3043-9f58e73208e4
md"""
## Aufgabe 3
Die Aufgabenstellung findet sich in Abschnitt 3.1."""

# ╔═╡ 3ac41afa-e2cf-4dcd-ab1b-cc36b0c67d51
md"""An die resultierenden Kraft
```math
\underline{F}_\mathrm{res} = \underline{F}_1 + \underline{F}_2
```
sind zwei Forderungen gestellt. Der Betrag soll 500 N betragen und die Kraft soll vertikal nach unten gerichtet sein. Das lässt sich übersetzen in
```math
\underline{F}_\mathrm{res} = 0\,\underline{e}_x -500\,\mathrm{N}\, \underline{e}_y\;.
```

"""

# ╔═╡ 48831c6d-6a59-4306-876f-33644a48d545
md"""Wir rechnen im Folgenden mit den Zahlenwerte und vereinbaren, dass alle Kräfte in der Einheit Newton angegeben sind. Es gelten die folgenden Zahlenwerte."""

# ╔═╡ cf2bc141-214b-4de0-b5e2-1550c7507830
begin
	Fres = [0.0; -500.0]
	α = deg2rad(70.0)
	β = deg2rad(30.0)
end;	

# ╔═╡ 2f463ad1-e1a7-479d-800f-8c8fa099b821
md"""
Die oben stehende Formel für die resultierende Kraft lässt sich unter Berücksichtigung der Abbildung zur Aufgabenstellung wie folgt in Matrixschreibweise übersetzen.
```math
\underline{F}_\mathrm{res} = 
\begin{Bmatrix}
0\\-500\,\mathrm{N}
\end{Bmatrix}
=
\begin{bmatrix}
\cos\alpha&-\sin\beta\\
 -\sin\alpha&-\cos\beta 
\end{bmatrix}
\begin{Bmatrix}
F_1\\F_2
\end{Bmatrix}\;.
```
Die 2x2-Matrix, die sogenannte Koeffizientenmatrix des linearen Gleichungssystems, nennen wir im Code `A`.
"""

# ╔═╡ 7933ea77-9009-4e90-93d9-212123b8b92b
A = [cos(α) -sin(β);-sin(α) -cos(β)]

# ╔═╡ 668cd6a6-179f-4d62-afc9-bb954ea0f84b
md"""Die Lösung dieses Gleichungssystems ist auch von Hand sehr leicht möglich. In Julia kann sie über den Operator \ ermittelt werden."""

# ╔═╡ 0e43a962-6c4d-4ecc-b380-1f2c0697f29a
erg = A\Fres

# ╔═╡ 803d9533-85b3-4836-8861-879adced0dc2
md"""Die Kraft ``F_1`` hat den Betrag $(round(erg[1],digits=2)) N und die Kraft ``F_2`` hat den Betrag $(round(erg[2],digits=2)) N."""

# ╔═╡ bd8764f2-78fa-4524-afb9-3f09ced0fb96
md"""Wir überprüfen, ob das gefundene Ergebnis (Variable `erg`) das lineare Gleichungssystem erfüllt."""

# ╔═╡ cbbd6258-53e2-486e-bf48-a9e4d058239e
abweichung = A*erg - Fres

# ╔═╡ d648ec70-371b-4f06-857b-4c0da66dbcef
md"""Anmerkung: Bei numerischen Berechnungen ergibt sich häufig nicht *exakt* Null. Im Vergleich zu den betrachteten Kräfte ist die Abweichung in ``x``-Richtung jedoch *praktisch* Null. Die Abweichung resultiert aus der endlichen Zahl an Stellen, mit denen der Computer rechnet (hier `Float64`, also Gleitkommazahl mit 64 Bit Speicherbelegung)."""

# ╔═╡ Cell order:
# ╟─d999c19c-4807-11ef-3043-9f58e73208e4
# ╟─3ac41afa-e2cf-4dcd-ab1b-cc36b0c67d51
# ╟─48831c6d-6a59-4306-876f-33644a48d545
# ╠═cf2bc141-214b-4de0-b5e2-1550c7507830
# ╟─2f463ad1-e1a7-479d-800f-8c8fa099b821
# ╠═7933ea77-9009-4e90-93d9-212123b8b92b
# ╟─668cd6a6-179f-4d62-afc9-bb954ea0f84b
# ╠═0e43a962-6c4d-4ecc-b380-1f2c0697f29a
# ╟─803d9533-85b3-4836-8861-879adced0dc2
# ╟─bd8764f2-78fa-4524-afb9-3f09ced0fb96
# ╠═cbbd6258-53e2-486e-bf48-a9e4d058239e
# ╟─d648ec70-371b-4f06-857b-4c0da66dbcef
