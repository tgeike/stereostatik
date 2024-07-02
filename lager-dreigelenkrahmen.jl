### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 4650adbc-9f49-4ed3-a6ec-a5be75e692b5
using LinearAlgebra,Plots

# ╔═╡ 24be9b30-3542-11ef-2018-43946ef24224
md"""
# Technische Berechnungen mit Julia
## Lagerreaktionen bei einem Dreigelenkrahmen (Statik von Systemen starrer Körper)
### Einführung
Es sollen die Auf- und Zwischenlagerreaktionen für den Dreigelenkrahmen berechnet werden.

#### Lerninhalte
1) **Mechanik**: statische Bestimmheit, Freischneiden, Gleichgewichtsbedingungen aufstellen, Lagersymbolik, Lagerreaktionen, Einflussmatrix
2) **Mathematik**: Lösbarkeit von linearen Gleichungssystemen, Rank und Determinante einer Matrix, singuläre vs. reguläre Matrix
3) **Programmierung**: Übertragen eines linearen Gleichungssystems in Computercode und Lösen des Gleichungssystems, Definieren von Funktionen, Diagrammerstellung (Funktion einer Veränderlichen)  

Die Aufgabe wird bei I. Szabo im *Repertorium und Übungsbuch der Technischen Mechanik* (Springer, 3. Auflage, 1972) auf Seite 26ff grafisch und rechnerisch gelöst."""

# ╔═╡ 2fe108ee-762e-4d45-b5ea-89a30e853ee4
md"""
#### Leseempfehlungen zu den mathematischen Grundlagen
**Meyberg und Vachenauer** *Höhere Mathematik 1* (Springer, 6. Auflage, 2001): Kapitel 6 *Lineare Algebra*, insbesondere §1 Lineare Gleichungssysteme und Matrizen

Lösung linearer Gleichungssysteme: Unterscheidung von 3 Fällen bezüglich der Lösbarkeit eines inhomogenen Gleichungssystems (Seite 255); Satz 1.2: Lösbarkeitstest und Struktur der Lösungsmenge (Seite 260).

**Papula** *Mathematik für Ingenieure und Naturwissenschaftler, Band 1* (Springer Vieweg, 15. Auflage, 2018): Teil I *Allgemeine Grundlagen*, Kapitel 5 *Lineare Gleichungssysteme*, insbesondere Abschnitt 5.2 und 

**Papula** *Mathematik für Ingenieure und Naturwissenschaftler, Band 2* (Springer Vieweg, 14. Auflage, 2015): Teil I *Lineare Algebra*, Kapitel 4 *Ergänzungen* sowie Kapitel 5 *Lineare Gleichungssysteme*; in Kapitel 4 insbesondere die Abschnitte 4.1 Reguläre Matrix und 4.4 Rang einer Matrix sowie in Kapitel 5 der Abschnitt 5.3 Lösungsverhalten eines linearen (m,n)-Gleichungssystems."""

# ╔═╡ 819a1f6b-8ab0-4f59-9fe5-b73bcbe113ff
md"""
### Schritt 1: Pakete laden und gegebene Zahlenwerte in Computercode übertragen
Bevor wir in die fachlichen Inhalte einsteigen, laden wir die notwendigen Pakete."""

# ╔═╡ 0a30e45c-8e6f-437e-83fd-2cea5e1e922b
md"""
Alle gegebenen Größen (Längen, eingeprägte Kräfte) werden als Gleitkommazahl (Float, konkret Float64 in Jula) im Code hinterlegt.
Alle Längen sind in der Einheit m (Meter) und alle eingeprägten Kräfte in der Einheit kN (Kilonewton) angegeben. Alle gesuchten Größen sind Kräfte und somit in der Einheit kN zu erwarten. Die resultierenden Momente in den Gleichgewichtsbedingungen sind in kN m angegeben.
"""

# ╔═╡ ab0bdfc2-98d2-41e4-9f1a-f80ce59b987b
begin
	l1 = 12.0
	l2 = 6.0
	h1 = 12.0
	h2 = 9.0
	F1 = 1.0
	F2 = 4.0
	F3 = 0.3*l1
	α = π/6
end;

# ╔═╡ 4ca11cb2-03c2-4702-903c-7c251ce89dcc
md"""
Wenn nichts weiteres angegeben ist, nutzen die trigonometrischen Funktionen (Sinus, Kosinus) den Winkel im Bogenmaß. Daher ist der Winkel ``\alpha`` hier im Bogenmaß angegeben.

Randnotiz: Wenn der Datentyp einer Größe bestimmt werden soll, gelingt das in Julia mittels `typeof()`. Im unten stehenden Beispiel: Der Typ von `l1` ist $(typeof(l1))."""

# ╔═╡ cdc881de-4b69-47ad-adfe-a6468e6756fa
typeof(l1)

# ╔═╡ 1db74e18-557c-4f7a-8c11-40a5258a77d2
md"""
### Schritt 2: Freischneiden und Gleichgewichtsbedingungen aufstellen
Der Dreigelenkrahmen besteht aus zwei starren Teilen, die in C gelenkig miteinander verbunden sind. Bei zwei Körpern können höchstens sechs linear unabhängige Gleichgewichtsbedingungen formuliert werden (3 Gleichungen je Körper).
Zur Bestimmung der Unbekannten stehen also höchstens sechs Gleichungen zur Verfügung. Diese können beispielsweise die drei Gleichgewichtsbedingungen Kräftegleichgewicht in x-Richtung, Kräftegleichgewicht in y-Richtung und Momentengleichgewicht um eine Achse senkrecht zur Zeichenebene für jedes der beiden Teile sein. Alternativ können selbstverständlich auch bis zu sechs Momentengleichgewichte (an mindestens zwei Systemen und bezüglich verschiedener Momentenbezugspunkte) gewählt werden.


Insgesamt gibt es sechs unbekannte Größen: je zwei Lagerreaktionen in A, B und C. Warum zwei? Die Lager in A, B und C sind gelenkige Lager. In der Ebene können Sie Kräfte in beliebiger Richtung aufnehmen. Dazu müssen zwei unabhängige Bestimmungsstücke für jede Lagerreaktion angegeben werden. Wir arbeiten mit den (skalarwertigen) Komponenten in `x`- und `y`-Richtung.


Zur statischen Bestimmtheit: Wie bereits oben argumentiert, liegen sechs Gleichungen für sechs Unbekannte vor. Die notwendige Bedingung für statische Bestimmtheit ist demnach erfüllt. Genaueres Hinschauen zeigt, dass das System keine Bewegungsmöglichkeit hat (kein Wackeln) und thermische Ausdehnungen oder leichte Abweichungen der Abmaße nicht zu Verspannungen im System führen. Das System ist in der gezeigten Form statisch bestimmt. 

Zur Erinnerung: Statische Bestimmtheit bezieht sich auf das System unabhängig von den konkreten Lasten.
"""

# ╔═╡ 5ae8f60f-aa4a-4f8e-8bb6-02ff8c9a26a1
md"""
### Schritt 3: Übertragen der Gleichungen in Computercode (Matrixform)
#### Koeffizientenmatrix
Die Koeffizientenmatrix ``\mathbf{A}`` enthält die Informationen, mit welchen Koeffizienten (Vorfaktoren) die einzelnen Unbekannten in welchen Gleichungen auftauchen. Sie enthält häufig bei dieser Art von Problem vielen Nullen.

```math
\mathbf{A} =
\begin{bmatrix}
 0 & 0 & 0 & 0 & -h_1 & l_1\\ 1 & 0 & 0 & 0 & 1 & 0\\ 0 & 1 & 0 & 0 & 0 & 1\\ 0 & 0 & 0 & 0 & h_2 & l_2\\ 0 & 0 & 1 & 0 & -1 & 0\\ 0 & 0 & 0 & 1 & 0 & -1
\end{bmatrix}
```
"""

# ╔═╡ a19b755d-c4ba-44f3-9d79-41fea197e44a
A = [0 0 0 0 -h1 l1; 1 0 0 0 1 0; 0 1 0 0 0 1; 0 0 0 0 h2 l2; 0 0 1 0 -1 0; 0 0 0 1 0 -1]

# ╔═╡ 95ab5197-ba90-4b34-a2e9-79002a810c5e
md"""
Wir wollen im nun den Rang und die Determinante der Koeffizientenmatrix bestimmen. Von Hand wären das durchaus aufwändige Berechnungen. Mit Julia gelingt es mit jeweils einer einfachen Zeile Code.

Der Befehl `rank` gibt uns den Rang der Koeffizientenmatrix an. Hier gilt ``
\mathrm{rank}(\mathbf{A})=`` $(rank(A)). Rang 6 bedeutet bei sechs Gleichungen, dass alle Gleichungen unabhängig voneinander sind.
Die Determinante ist von Null verschieden. Beide Aussagen, zum Rang und zur Determinante, zeigen, dass die Koeffizientenmatrix regulär ist. Ein lineares Gleichungssystem mit einer solchen Koeffizientenmatrix ist eindeutig lösbar.
"""

# ╔═╡ c2923f3e-4901-4bd7-8d8b-92999fc2eb5f
md"""Die Aussage zur eindeutigen Lösbarkeit des Gleichungssystem und die Aussage zur statischen Bestimmheit sind zwei Seiten einer Medaille!"""

# ╔═╡ 1eb64930-200e-40fa-9cb4-cc4c88382848
rank(A)

# ╔═╡ c71e4b98-3c82-4799-99db-3d70d654ab20
det(A)

# ╔═╡ 15e893fa-20d3-4c41-952b-dac89df21662
md"""
#### Rechte Seite
Häufig wird man alle eingeprägten Kräfte in einer Spaltenmatrix ``\mathbf{b}`` zusammenfassen ("rechte Seite"). Alternativ kann man bei ``n`` eingeprägten Kräften und ``m`` Gleichungen die rechte Seite auch als ``m\times n``-Matrix ``\mathbf{B}`` schreiben, wobei jede Spalte einer eingeprägten Kraft zugeordnet ist. Im vorliegenden Fall gibt es drei eingeprägte Kräfte, so dass die rechte Seite sich in der Form

```math
\mathbf{B} =
\begin{bmatrix}
-h_1/2 & 0 & l_1/2\\ 1 & 0 & 0\\ 0 & 0 & 1\\ 0 & h_2 \cos(\alpha) & 0\\ 0 & -\cos(\alpha) & 0\\ 0 & \sin(\alpha) & 0]
\end{bmatrix}
```
und
```math
\mathbf{b} = \mathbf{B} 
\begin{Bmatrix}
F_1\\F_2\\F_3
\end{Bmatrix}
```


schreiben lässt. Zur Erinnerung ``F_1=`` $(F1) kN, ``F_2=`` $(F2) kN und ``F_3=`` $(round(F3,digits=2)) kN.
"""

# ╔═╡ 6cf91eb8-153f-468a-a91a-36c77d93bb8c
B = [-0.5*h1 0 0.5*l1; 1 0 0; 0 0 1; 0 h2*cos(α) 0; 0 -cos(α) 0; 0 sin(α) 0]

# ╔═╡ 884fd01c-500a-4311-8c25-80e922952d47
b = B*[F1;F2;F3]

# ╔═╡ 7ec2dfde-39c7-4533-aa70-7636d4f4d4d1
md"""
### Schritt 4: Lösen des linearen Gleichungssystems
Bei der händischen Lösung solcher Aufgaben beginnt jetzt häufig der nervige Teil.

In Julia können die drei Gleichungssysteme durch `A\B` in Sekundenbruchteilen gelöst werden.
"""

# ╔═╡ 3cd1e5dd-f415-4887-a623-14184b5278df
L = A\B

# ╔═╡ edf9ca16-780f-4e34-9442-b3d8b92b5337
md"""
Was sagt uns die 6x3-Matrix ``\mathbf{L}``? Die Matrix ``\mathbf{L}`` verbindet die gesuchten Lagerreaktionen (sechs Größen) mit den eingeprägten Kräften (drei Größen). 

Die Spaltenmatrix ``\mathbf{F}`` mit den sechs gesuchten Lagerreaktionen entsteht aus ``\mathbf{L}`` durch Multiplikation mit der Spaltenmatrix ``\{F_1,F_2,F_3\}^T``, die die Zahlenwerte für die eingeprägten Lasten enthält.

Man kann die Zahlen in der Matrix ``\mathbf{L}`` die Einflusszahlen nennen. Sie zeigen, welche Einfluss eine gewählte eingeprägte Kraft auf die einzelnen Lagerreaktionen hat. Ist eine der Zahlen 0, so heißt das, dass die betrachtete eingeprägte Kraft keinen Einfluss auf die betrachtete Lagerreaktion hat.

Folgendes Ergebnis ergibt sich für die sechs Lagerreaktionen (alle Werte in kN).
"""

# ╔═╡ 17199777-dd6e-4c00-9d82-2cd7109be17b
F = L*[F1;F2;F3]

# ╔═╡ 4dc67364-cacf-4c93-873e-7bebce9b9a2e
md"""**Antwortsatz**: Die Lagerreaktionen sind wie folgt: ``F_{\mathrm{A}x}=`` $(round(F[1],digits=3)) kN, ``F_{\mathrm{A}y}=`` $(round(F[2],digits=3)) kN, ``F_{\mathrm{B}x}=`` $(round(F[3],digits=3)) kN, ``F_{\mathrm{B}y}=`` $(round(F[4],digits=3)) kN, ``F_{\mathrm{C}x}=`` $(round(F[5],digits=3)) kN, ``F_{\mathrm{C}y}=`` $(round(F[6],digits=3)) kN.

Der jeweilige Richtungssinn ist der Freischnittskizze zu entnehmen."""

# ╔═╡ 959d3223-0a37-49bb-af89-219f97a21994
md"""Hinweis: Alternativ kann auch zuerst ``\mathbf{B}`` mit der Spaltenmatrix ``\{F_1,F_2,F_3\}^T`` multipliziert werden und dann das lineare Gleichungssystem gelöst werden."""

# ╔═╡ a6466b41-9f16-4c4b-a9f0-fb67cf0ddf3d
A\(B*[F1;F2;F3])

# ╔═╡ 6e3156b7-22a6-4f7f-9104-fbc330e46534
md"""Aus den Komponenten können die Beträge der Lagerreaktionen in A, B und C berechnet werden. Wir tun dies weiter unten im Rahmen einer weiterführenden Überlegung."""

# ╔═╡ 85e56034-edad-46c3-98e5-10031524bba8
md"""
### Schritt 5: Weiterführende Überlegungen

Was passiert, wenn die beiden Höhen, ``h_1`` und ``h_2`` mit einem Faktor ``\chi`` skaliert werden? In anderen Worten: Die beiden Höhen sollen beide halbiert oder verdoppelt oder mit einem anderen Faktor gestaucht oder gestreckt werden. 
Skalierungsfaktor 0 heißt, dass alle drei Lager, A, B und C, auf einer horizontalen Linie liegen.

Bleibt das System stets statisch bestimmt?"""

# ╔═╡ bc4adb21-cea4-4d4f-ad38-156d8c78a24f
md"""
#### Determinante und Rang
Wir definieren die Koeffizientenmatrix ``\mathbf{A}`` als Funktion des Skalierungsfaktors ``\chi``
und erstellen ein Diagramm, das die Determinante der Koeffizientenmatrix als Funktion des Skalierungsfaktors ``\chi`` zeigt."""

# ╔═╡ baf12a1c-5a3e-493b-bbeb-fa858ccf3766
A_skal(χ) = [0 0 0 0 -h1*χ l1; 1 0 0 0 1 0; 0 1 0 0 0 1; 0 0 0 0 h2*χ l2; 0 0 1 0 -1 0; 0 0 0 1 0 -1]

# ╔═╡ fc4dcff4-cd1c-48f9-8487-a6e0702c31c7
detA(χ) = det(A_skal(χ))

# ╔═╡ c84125f0-f76e-41bd-aefd-6b61d53aea4c
plot(-1:0.1:1,detA,label=false,xlabel="χ",ylabel="det A",size=(600,300),lw=2)

# ╔═╡ aaf79993-cde0-4d5a-a263-8a7be7b6ed01
md"""Für den Skalierungsfaktor 0 ist die Determinante 0. Ansonsten ist die Determinate ungleich 0. Für ``\chi=0`` ist die Koeffizientenmatrix demnach singulär. Das ergibt sich auch, wenn der Rang der Matrix berechnet wird. Für den Rang ergibt sich $(rank(A_skal(0.0))).

Schlussfolgerung: Für ``\chi=0`` gibt es keine eindeutige Lösung für die Lagerreaktionen. Das mechanische System ist nicht statisch bestimmt.
"""

# ╔═╡ 1be08e01-6da1-4be4-8966-51f7092014ef
rank(A_skal(0.0))

# ╔═╡ ca55428d-ff17-4a00-83bd-f994c5a5e971
md"""Empfehlung: Lesen Sie die [Dokumentation zum Befehl rank](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.rank), insbesondere die Anmerkung zur Genauigkeit (*Numerical rank can be a sensitive and imprecise characterization of ill-conditioned matrices with singular values that are close to the threshold tolerance ...*)."""

# ╔═╡ c672528f-6dc0-4561-83bb-574f0169404d
md"""Auch die rechte Seite wird in Abhängigkeit vom Skalierungsfaktor ``\chi`` formuliert."""

# ╔═╡ 1f0dab4d-9dfb-4a9b-a60c-8088c6d00338
B_skal(χ) = [-0.5*h1*χ 0 0.5*l1; 1 0 0; 0 0 1; 0 h2*cos(α) 0; 0 -cos(α) 0; 0 sin(α) 0]

# ╔═╡ c3c879af-00aa-4101-8912-80a8f6743333
md"""
Nun bestimmen wir den Rang der Matrix ``(\mathbf{A} | \mathbf{b})``, die durch Nebeneinandersetzen von ``\mathbf{A}`` und ``\mathbf{b}`` entsteht (Befehl `hcat` in Julia). Wenn der Rang dieser Matrix 6 ist, ist das lineare Gleichungssystem nicht lösbar. Wenn der Rang 5 ist, gibt es unendliche viele Lösungen mit einer freien Variable."""

# ╔═╡ 35673480-3f93-423a-b2b1-788517eb0c0b
hcat(A_skal(0.0),B_skal(0.0)*[F1;F2;F3])

# ╔═╡ b09ea6c4-48e4-40d0-a4bd-cceffd1ce0b6
rank(hcat(A_skal(0.0),B_skal(0.0)*[F1;F2;F3]))

# ╔═╡ 92d8cb5a-1c10-4ff6-85ac-be8dc41ac576
md"""Fazit: Für ``\chi=0`` ist das lineare Gleichungssystem nicht lösbar; es gibt keine Lösung. Wir wissen bereits, dass bei diesem Wert des Skalierungsfaktors die statische Bestimmtheit nicht mehr gegeben ist. In diesem Grenzfall gibt es eine infinitesimale Bewegungsmöglichkeit des Rahmens."""

# ╔═╡ d293653a-8b00-4f1f-8837-91a777785eda
md"""
#### Lagerreaktionen in Abhängigkeit vom Skalierungsfaktor
Zum Schluss betrachten wir die Lagerreaktionen in Abhängigkeit von χ.

Die untenstehende Funktion kann die Lagerreaktionen in den Punkten A, B und C in Abhängigkeit vom Wert ``\chi`` zurückliefern; entweder den Betrag der Lagerkraft oder die skalarwertige ``x``-Komponente."""

# ╔═╡ 762c936d-9477-411f-b8bd-d97dfb2619bf
function f(χ,k::Int64;betrag::Bool=true)
	L = A_skal(χ)\(B_skal(χ)*[F1;F2;F3])
	if k in (1,2,3)
		Fk = L[2*(k-1)+1:2*k]
	else
		return NaN
	end
	if betrag
		return sqrt(Fk[1]^2 + Fk[2]^2)
	else
		return Fk[1]
	end
end

# ╔═╡ 794d544c-0ac5-4b6f-aa22-eaa421a5d725
scatter(-0.3:0.11:1,[s->f(s,1),s->f(s,2)],label=["Lager A" "Lager B"], xlabel="χ",ylabel="Betrag Lagerkraft [kN]",size=(600,350))

# ╔═╡ c2b3feb6-c5cc-4a9d-8f8a-f73fa0d837d7
md"""Für ``\chi=0`` werden die Lagerreaktionen unendlich groß. Im Diagramm wurde die 0 ausgespart."""

# ╔═╡ Cell order:
# ╟─24be9b30-3542-11ef-2018-43946ef24224
# ╟─2fe108ee-762e-4d45-b5ea-89a30e853ee4
# ╟─819a1f6b-8ab0-4f59-9fe5-b73bcbe113ff
# ╠═4650adbc-9f49-4ed3-a6ec-a5be75e692b5
# ╟─0a30e45c-8e6f-437e-83fd-2cea5e1e922b
# ╠═ab0bdfc2-98d2-41e4-9f1a-f80ce59b987b
# ╟─4ca11cb2-03c2-4702-903c-7c251ce89dcc
# ╠═cdc881de-4b69-47ad-adfe-a6468e6756fa
# ╟─1db74e18-557c-4f7a-8c11-40a5258a77d2
# ╟─5ae8f60f-aa4a-4f8e-8bb6-02ff8c9a26a1
# ╠═a19b755d-c4ba-44f3-9d79-41fea197e44a
# ╟─95ab5197-ba90-4b34-a2e9-79002a810c5e
# ╟─c2923f3e-4901-4bd7-8d8b-92999fc2eb5f
# ╠═1eb64930-200e-40fa-9cb4-cc4c88382848
# ╠═c71e4b98-3c82-4799-99db-3d70d654ab20
# ╟─15e893fa-20d3-4c41-952b-dac89df21662
# ╠═6cf91eb8-153f-468a-a91a-36c77d93bb8c
# ╠═884fd01c-500a-4311-8c25-80e922952d47
# ╟─7ec2dfde-39c7-4533-aa70-7636d4f4d4d1
# ╠═3cd1e5dd-f415-4887-a623-14184b5278df
# ╟─edf9ca16-780f-4e34-9442-b3d8b92b5337
# ╠═17199777-dd6e-4c00-9d82-2cd7109be17b
# ╟─4dc67364-cacf-4c93-873e-7bebce9b9a2e
# ╟─959d3223-0a37-49bb-af89-219f97a21994
# ╠═a6466b41-9f16-4c4b-a9f0-fb67cf0ddf3d
# ╟─6e3156b7-22a6-4f7f-9104-fbc330e46534
# ╟─85e56034-edad-46c3-98e5-10031524bba8
# ╟─bc4adb21-cea4-4d4f-ad38-156d8c78a24f
# ╠═baf12a1c-5a3e-493b-bbeb-fa858ccf3766
# ╠═fc4dcff4-cd1c-48f9-8487-a6e0702c31c7
# ╠═c84125f0-f76e-41bd-aefd-6b61d53aea4c
# ╟─aaf79993-cde0-4d5a-a263-8a7be7b6ed01
# ╠═1be08e01-6da1-4be4-8966-51f7092014ef
# ╟─ca55428d-ff17-4a00-83bd-f994c5a5e971
# ╟─c672528f-6dc0-4561-83bb-574f0169404d
# ╠═1f0dab4d-9dfb-4a9b-a60c-8088c6d00338
# ╟─c3c879af-00aa-4101-8912-80a8f6743333
# ╠═35673480-3f93-423a-b2b1-788517eb0c0b
# ╠═b09ea6c4-48e4-40d0-a4bd-cceffd1ce0b6
# ╟─92d8cb5a-1c10-4ff6-85ac-be8dc41ac576
# ╟─d293653a-8b00-4f1f-8837-91a777785eda
# ╠═762c936d-9477-411f-b8bd-d97dfb2619bf
# ╠═794d544c-0ac5-4b6f-aa22-eaa421a5d725
# ╟─c2b3feb6-c5cc-4a9d-8f8a-f73fa0d837d7
