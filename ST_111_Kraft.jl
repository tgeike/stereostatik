### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ af747cf4-21b2-4fe1-9909-096d3410f521
using LinearAlgebra

# ╔═╡ ece939bc-47f5-11ef-3990-7324aee47874
md"""
## Kraft: Aufgabe 1
Aufgabenstellung im Kapitel 3 im Abschnitt 3.1 Kraft

Bei der Programmierung werden verschiedene Datentypen unterschieden. Für unsere Zwecke sind ganze Zahlen (integer) und Gleitkommazahlen (float) die beiden wichtigsten. Der Typ einer Variable in Julia kann mit dem Befehl `typeof` bestimmt werden.

Vorerst rechnen wir ohne Einheiten. Folgende Werte sind für die skalarwertigen Komponenten der beiden Kräfte gegeben (in einem kartesischen Koordinatensystem).

Besonderheit von Pluto: Wenn mehr als eine Zeile in einer Pluto-Zelle stehen soll, müssen diese Zeilen in einen Block mit `begin` und `end` eingeschlossen sein. Das Semikolon am Ende unterdrückt die Ausgabe.
"""

# ╔═╡ 5c20cfee-2654-4ea0-8c5f-d5dd872933b1
begin 
	F1x = 100.0 # N
	F1y = 200.0 # N
	F2x = -50.5 # N
	F2y = 50.0 # N
end;

# ╔═╡ 99f8649c-a747-4b90-adb5-297439818a6c
typeof(F1x)

# ╔═╡ 23b5d06c-86bb-4ab4-9896-ef9eca538a67
md"""Wir sehen, dass die Variable `F1x` vom Typ `Float64` ist. Das heißt, es ist eine Gleitkommazahl mit 64 Bit Speicherbelegung. Das ist der Standarddatentyp für Gleitkommazahlen in Julia."""

# ╔═╡ b005c53a-b4ab-4a3f-8b59-1cc623c76bd3
md"""Nun speichern wir die beiden Kraftvektoren in Spaltenmatrizen."""

# ╔═╡ fb5f9bba-bc4d-4b9d-a88d-2a83d112855d
F1 = [F1x;F1y]

# ╔═╡ 617b89a7-e342-4968-9cbf-22e0a4ccdbc2
typeof(F1)

# ╔═╡ 6f225060-84b5-4cd5-b082-f64fb1c3d3f5
md"""`F1` ist ein Array von Gleitkommazahlen."""

# ╔═╡ 0aed9f88-4eaf-4549-89bf-e2d4fdbc0854
F2 = [F2x;F2y]

# ╔═╡ 768b5fc4-13a3-4609-a114-c16943f6efa7
md"""Die resultierende Kraft ist die Summe der beiden Kräfte (vektorielle Größen). Da beide Kräfte in der gleichen Basis (kartesisch, hier mit ``x``- und ``y``-Achse) angegeben sind, können einfach die skalarwertigen Komponenten addiert werden. Konkret heißt das hier, dass die Spaltenmatrizen addiert werden können."""

# ╔═╡ 5a288ad3-3775-425c-8508-5c4491811411
Fres = F1 + F2

# ╔═╡ f1e5878e-4fc4-4869-9e2e-bffb50cd7afe
md"""Wir wollen den Betrag der resultierenden Kraft ausrechnen. Dazu könnte man, in Analogie zum händischen Vorgehen auf Basis des Satzes von Pythagoras,
```math
|F_\mathrm{res}|=\sqrt{F_{\mathrm{res}\,x}^2 + F_{\mathrm{res}\,y}^2}\;,
```
folgende Codezeile schreiben."""

# ╔═╡ 076f5338-9984-4c8c-9d84-48dd7cf01095
Fres_betrag = sqrt(Fres[1]^2 + Fres[2]^2)

# ╔═╡ 6e03627a-896a-4a38-a8ef-6f961d61ead8
md"""Der Betrag der resultierenden Kraft ist $(round(Fres_betrag,digits=2)) N."""

# ╔═╡ fcf278e2-a658-46db-a880-7dbe8ba79815
md"""Anmerkung: Die eckige Klammer hinter einem Variablennamen erlaubt den Zugriff auf ein bestimmtes Element des Arrays. `Fres[1]` ist das erste Element im Array `Fres`, also die skalarwertige ``x``-Komponente der resultierenden Kraft. Der Operator `^2` ist die zweite Potenz der davor stehenden Größe. Die Funktion `sqrt` ist die Quadratwurzel (Englisch square root).

Typischerweise wird man Standardoperationen wie das Ausrechnen des Betrages nicht in dieser Form selbst programmieren. Stattdessen wird man auf vordefinierte Funktionen zurückgreifen. Hier bietet sich die Funktion `norm` aus dem Paket `LinearAlgebra` an."""

# ╔═╡ 39f42d1d-7856-4a36-93d6-6501f1319acd
norm(Fres)

# ╔═╡ 3eac2609-2869-4888-b10c-b384b8581ff9
md"""Abschließend berechnen wir noch die Richtung der resultierenden Kraft, die über den Winkel gegenüber der positiven ``x``-Achse charakterisiert werden soll. Es gilt

```math
\tan\varphi = \frac{F_{\mathrm{res}\,y}}{F_{\mathrm{res}\,x}}\;.
```
"""

# ╔═╡ 6a8cf9fa-a468-4eea-bdc7-253e153ee347
ϕ = atan(Fres[2],Fres[1])

# ╔═╡ ef6b4e44-3983-46c5-9685-c14f23e93df5
md"""Die Funktion `atan` (Arcustangens) kann mit einem oder mit zwei Argumenten aufgerufen werden. In der Version mit zwei Argumenten ist das erste Argument der Zähler und das zweite Argument der Nenner des Ausdrucks, von dem der Arcustangens zu berechnen ist.

Der Winkel wird im Bogenmaß zurückgeliefert. Er kann mit `rad2deg` ins Gradmaß umgerechnet werden."""

# ╔═╡ 69b4dd1a-a00c-43e3-a8ac-ce957086b47a
rad2deg(ϕ)

# ╔═╡ cfba4edd-5516-4c63-bca3-1ef58c154050
md"""Der Winkel zwischen der Wirkungslinie der resulierenden Kraft und der positiven ``x``-Achse beträgt $(round(rad2deg(ϕ),digits=2))°."""

# ╔═╡ c566338d-4604-4fae-af45-b038ebb8d230
md"""Antwortsätze sollten in Pluto-Notebooks möglichst dynamisch angelegt werden, d. h. es sollte nicht das berechnete Ergebnis abgeschrieben werden, sondern im Antwortsatz sollte direkt auf die Variable zugegriffen werden. Dies geschieht über das \$-Zeichen. Da man in der Regel nicht alle Nachkommastellen angegeben will, muss die Ausgabe gerundet werden. Dafür ist die Funktion `round` vorhanden. Das Argument `digits` ermöglicht die Angabe der verbleibenden Nachkommastellen."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─ece939bc-47f5-11ef-3990-7324aee47874
# ╠═5c20cfee-2654-4ea0-8c5f-d5dd872933b1
# ╠═99f8649c-a747-4b90-adb5-297439818a6c
# ╟─23b5d06c-86bb-4ab4-9896-ef9eca538a67
# ╟─b005c53a-b4ab-4a3f-8b59-1cc623c76bd3
# ╠═fb5f9bba-bc4d-4b9d-a88d-2a83d112855d
# ╠═617b89a7-e342-4968-9cbf-22e0a4ccdbc2
# ╟─6f225060-84b5-4cd5-b082-f64fb1c3d3f5
# ╠═0aed9f88-4eaf-4549-89bf-e2d4fdbc0854
# ╟─768b5fc4-13a3-4609-a114-c16943f6efa7
# ╠═5a288ad3-3775-425c-8508-5c4491811411
# ╟─f1e5878e-4fc4-4869-9e2e-bffb50cd7afe
# ╠═076f5338-9984-4c8c-9d84-48dd7cf01095
# ╟─6e03627a-896a-4a38-a8ef-6f961d61ead8
# ╟─fcf278e2-a658-46db-a880-7dbe8ba79815
# ╠═af747cf4-21b2-4fe1-9909-096d3410f521
# ╠═39f42d1d-7856-4a36-93d6-6501f1319acd
# ╟─3eac2609-2869-4888-b10c-b384b8581ff9
# ╠═6a8cf9fa-a468-4eea-bdc7-253e153ee347
# ╟─ef6b4e44-3983-46c5-9685-c14f23e93df5
# ╠═69b4dd1a-a00c-43e3-a8ac-ce957086b47a
# ╠═cfba4edd-5516-4c63-bca3-1ef58c154050
# ╟─c566338d-4604-4fae-af45-b038ebb8d230
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
