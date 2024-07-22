### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 552dd09c-2b77-4db0-8a8f-f7ef408faa9a
using LinearAlgebra,Unitful

# ╔═╡ ed9c8cb4-45f8-11ef-1ecd-d173064086ef
md"""
## Kraft: Aufgabe 2

Die Aufgabenstellung findet sich im Abschnitt 3.1.
"""

# ╔═╡ cf4bf6fe-e708-4bf7-904d-f33c499148cb
md"""Es sind die folgenden Größen gegeben. Anders als bei Aufgabe 1 wollen wir hier die Einheiten in unserem Julia-Code berücksichtigen. Dazu dient das Paket `Unitful`, das wir oben bereits geladen haben. Das 'b' in 'F1b' usw. weist auf den Betrag der Größe hin."""

# ╔═╡ 314a5d47-198c-421a-a177-2192b98c59e3
begin 
	F1b = 100.0u"kN"
	αdeg = 50
	α = deg2rad(αdeg)
	F2b = 220.0u"kN"
	βdeg = 60
	β = deg2rad(βdeg)
	F3b = 180.5u"kN"
end;

# ╔═╡ d396c5b3-3973-47a1-9d22-a5936fe43d53
md"""Für Winkel nutzt der Autor in der Regel nicht die Funktionalität von `Unitful`. Wie das geht, wird am Ende der Aufgabe gezeigt. Da die trigonometrischen Funktionen wie Sinus und Kosinus den Winkel im Bogenmaß erwarten, müssen wir die im Gradmaß gegebenen Winkel (z. B. ``α`` ist $(round(rad2deg(α),digits=1))°) ins Bogenmaß umrechnen. Das erledigt die Funktion `deg2rad` für uns."""

# ╔═╡ 19fbefd4-43e3-47fc-ab54-8f6984f5dd96
md"""
#### Variante 1
Wir wollen in Variante 1 die Berechnungsschritte im Computercode so abbilden, wie wir auch von Hand rechnen würden.
Mithilfe der Definition von Sinus (Gegenkathete durch Hypotenuse) und Kosinus (Ankathete durch Hypotenuse) lassen sich die Komponentendarstellungen der drei Kräfte leicht gewinnen."""

# ╔═╡ 53d54f9d-f4bd-4fd3-88b2-ae3c1ede7269
F1 = [F1b*cos(α);F1b*sin(α)]

# ╔═╡ f6b0ee9b-cbe0-40e1-b3a3-420321e4cca3
F2 = [-F2b*sin(β);-F2b*cos(β)]

# ╔═╡ 2b6eb2c8-03f4-423f-a5d2-c58861fbafb1
F3 = [0.0u"kN";F3b]

# ╔═╡ 47e806a1-89f8-41f0-bbce-d977eb33b722
md"""Die resultierende Kraft ergibt sich durch die vektorielle Addition aller Einzelkräfte."""

# ╔═╡ c2ac80f2-affa-4f8a-99e4-87e2280c65cf
Fres = F1 + F2 + F3

# ╔═╡ 4443c108-ca2d-4217-942d-6ed97ff7c5c3
Fres_betrag = norm(Fres)

# ╔═╡ 8cd9faaf-e075-4bdd-8bb3-f78ee9741b9a
md"""Der Betrag der resultierenden Kraft ist $(round(ustrip(u"kN",Fres_betrag),digits=2)) kN."""

# ╔═╡ 8c2e0f12-664d-436b-8e07-f6d6ec338159
ϕ = atan(Fres[2],Fres[1])

# ╔═╡ 72c0f5d8-74aa-4b50-bebb-3c302b5770a9
rad2deg(ϕ)

# ╔═╡ 5c158a1c-7c7c-44bb-a486-6fd37ca161f7
md"""Der Winkel gegenüber der positiven ``x``-Achse beträgt $(round(rad2deg(ϕ),digits=2))°."""

# ╔═╡ ee3f61b9-037a-4f9e-902c-1788fca2ca73
md"""
#### Variante 2
Angenommen, wir hätten diese Art von Aufgabe sehr häufig zu lösen. Dann wäre es vorteilhaft, eine Funktion zu schreiben, die aus Betrag und Winkel die Komponentendarstellung der Kraft berechnet.
Wir wollen eine solche Funktion im Folgenden entwickeln und dabei die Definiton von Funktionen in Julia kennen lernen.

Wir definieren eine Funktion 'kraft2d', die den Betrag der Kraft und den Winkel zu einer definierten Achse (im Gradmaß) entgegennimmt und dann die Komponentendarstellung zurückliefert.
Die Variable `winkel` enthält den Winkel zwischen der Achse und der Wirkungslinie im Gradmaß. In der Funktion `kraft2d` wird der Winkel ``\alpha`` im Bogenmaß (rad) aus der Variable `winkel` im Gradmaß (deg) berechnet. Wichtig: Der Winkel ist vorzeichenbehaftet. Ein positiver Wert des Winkels verweist auf den positiven Drehsinn (hier entgegen dem Uhrzeigersinn).

Das dritte Argument `achse` (getrennt durch Semikolon von den ersten beiden Argumenten) ist optional. Wenn es beim Funktionsaufruf nicht angegeben wird, wird die positive ``x``-Achse als Bezugsachse für den Winkel benutzt. Die notwendige Fallunterscheidung erfolgt in Julia mit `if` und `elseif`. 
 """

# ╔═╡ c3a01db6-53d5-428b-94dd-eb3bfe67baad
function kraft2d(betrag,winkel;achse="x")
	α = deg2rad(winkel) # Der Winkel wird im Gradmaß erwartet.
	F = abs(betrag) # Falls ein negativer Wert angegeben wurde, wird dies korrigiert.
	if achse == "x"
		return F*[cos(α);sin(α)]
	elseif achse == "-x"
		return -F*[cos(α);sin(α)]
	elseif achse == "y"
		return F*[-sin(α);cos(α)]
	elseif achse == "-y"
		return F*[sin(α);-cos(α)]
	end
end

# ╔═╡ ad185dc4-6671-4582-9d49-e33f858c273c
kraft2d(F1b,αdeg)

# ╔═╡ 288523d7-9312-4475-a68b-d174fc3f12a1
kraft2d(F2b,-βdeg,achse="-y")

# ╔═╡ fb6587ad-e5a1-4743-8f7b-e71dfbcbcd33
kraft2d(F3b,0,achse="y")

# ╔═╡ dfbc43bb-4084-43ef-ae3b-0a1c2980eaec
md"""
#### Anhang: Winkel über `Unitful` abbilden
Zum Schluss wollen wir kurz auf die Darstellung von Winkel mit `Unitful` schauen. Wir können den Winkel, im unten stehenden Beispiel ``\psi``, im Gradmaß eingeben. Wenn wir dann die Sinusfunktion aufrufen, wird das Ergebnis korrekt ausgewertet. Die Umrechnung ins Bogenmaß kann über `uconvert` erfolgen."""

# ╔═╡ 573c074d-a3a4-47c2-9d05-9b6aa3f94d50
ψ = 30u"°"

# ╔═╡ 8df68801-680f-4697-9925-416af7adccec
sin(ψ)

# ╔═╡ 95835026-61af-41c3-b0f4-e420568879c1
uconvert(u"rad",ψ)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
Unitful = "~1.20.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "964b549a9e122158db51a3c2b1340e3d5dd00686"

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
# ╟─ed9c8cb4-45f8-11ef-1ecd-d173064086ef
# ╠═552dd09c-2b77-4db0-8a8f-f7ef408faa9a
# ╟─cf4bf6fe-e708-4bf7-904d-f33c499148cb
# ╠═314a5d47-198c-421a-a177-2192b98c59e3
# ╟─d396c5b3-3973-47a1-9d22-a5936fe43d53
# ╟─19fbefd4-43e3-47fc-ab54-8f6984f5dd96
# ╠═53d54f9d-f4bd-4fd3-88b2-ae3c1ede7269
# ╠═f6b0ee9b-cbe0-40e1-b3a3-420321e4cca3
# ╠═2b6eb2c8-03f4-423f-a5d2-c58861fbafb1
# ╟─47e806a1-89f8-41f0-bbce-d977eb33b722
# ╠═c2ac80f2-affa-4f8a-99e4-87e2280c65cf
# ╠═4443c108-ca2d-4217-942d-6ed97ff7c5c3
# ╟─8cd9faaf-e075-4bdd-8bb3-f78ee9741b9a
# ╠═8c2e0f12-664d-436b-8e07-f6d6ec338159
# ╠═72c0f5d8-74aa-4b50-bebb-3c302b5770a9
# ╟─5c158a1c-7c7c-44bb-a486-6fd37ca161f7
# ╟─ee3f61b9-037a-4f9e-902c-1788fca2ca73
# ╠═c3a01db6-53d5-428b-94dd-eb3bfe67baad
# ╠═ad185dc4-6671-4582-9d49-e33f858c273c
# ╠═288523d7-9312-4475-a68b-d174fc3f12a1
# ╠═fb6587ad-e5a1-4743-8f7b-e71dfbcbcd33
# ╟─dfbc43bb-4084-43ef-ae3b-0a1c2980eaec
# ╠═573c074d-a3a4-47c2-9d05-9b6aa3f94d50
# ╠═8df68801-680f-4697-9925-416af7adccec
# ╠═95835026-61af-41c3-b0f4-e420568879c1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
