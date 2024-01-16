#import "@preview/polylux:0.3.1": *
#import themes.university: *
#import "@preview/fletcher:0.3.0" as fletcher:node, edge
#import "@preview/codelst:1.0.0": sourcecode

#show: university-theme.with(
  short-author: "Louis T., Albin M.",
  short-title: "Présentation PageRank",
  short-date: "17/01/24",
)

#title-slide(
  authors: ("Louis Thevenet", "Albin Morisseau"),
  title: "Présentation PIM : PageRank",
  subtitle: "Groupe EF-03",
  date: "17 Janvier, 2024",
  institution-name: "ENSEEIHT",
  logo: image("logo.png", width: 60mm),
)

#slide(title: [Programme pirncipal])[
  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((0, 0), `Programme Principal`),
    node((1, 0), `PageRank`, shape: "circle"),
    edge((-1, 0), (0, 0), $"Début"$, "=>"),
    edge((0, 0), (1, 0), "->"),
  )

  - `Programme Principal` :
    + Traitement de la ligne de commande
    + Appel à PageRank

]

#slide(title: [PageRank])[
  #align(center, fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `PageRank`, shape: "circle"),
  ))
  - `PageRank` :
    + Traite les données d'entrée
    + Applique l'algorithme `PageRank`

]

#slide(title: [Lire Graphe])[
  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `pagerank`, shape: "circle"),
    node((2.5, 0), `lire_graphe`),
    edge((1, 0), (2.5, 0), "->"),
  )
  - Traite les données

]
#slide(title: [Matrices Pleines])[

  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `pagerank`, shape: "circle"),
    node((2.5, 0), `lire_graphe`),
    node((3, 1), `matrices_pleines`),
    edge((1, 0), (2.5, 0), "->"),
    edge((2.5, 0), (3, 1), "-->"),
  )

  - Traite les données
    - Cas Matrices Pleines
      - Crée la matrice $G$

]

#slide(
  title: [Matrices creuses],
)[
  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `pagerank`, shape: "circle"),
    node((2.5, 0), `lire_graphe`),
    node((3, 1), `matrices_pleines`),
    node((3, -1), `matrices_creuses`),
    edge((1, 0), (2.5, 0), "->"),
    edge((2.5, 0), (3, 1), "-->"),
    edge((2.5, 0), (3, -1), "-->"),
  )
  - Traite les données
    - Cas Matrices Creuses
      - Crée la matrice $M$ telle que $forall (i,j) in [|1,n|]^2, M_(i,j) in {0,1}$
      - Crée la vecteur $F$ tel que $forall i in [|1, n|], F_i = sum_(k =1)^n M_(i,k)$
]

#slide(title: [Vecteurs Creux])[
  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `pagerank`, shape: "circle"),
    node((2.5, 0), `lire_graphe`),
    node((3, 1), `matrices_pleines`),
    node((3, -1), `matrices_creuses`),
    node((3, -2), `vecteurs_creux`),
    edge((1, 0), (2.5, 0), "->"),
    edge((2.5, 0), (3, 1), "-->"),
    edge((2.5, 0), (3, -1), "-->"),
    edge((3, -1), (3, -2), "-->"),
  )
  - `type T_Matrice_Creuse est tableau de T_Vecteur_Creux`
]

#slide(title: [Vecteurs Creux : détails])[
// typstfmt::off
#sourcecode(```adb
type T_Cellule;
type T_Vecteur_Creux is access T_Cellule;
type T_Cellule is
  record
    Indice : Integer;
    Valeur : Long_Float;
    Suivant : T_Vecteur_Creux;
  end record;
    ```)
]
// typstfmt::on

#slide(title: [PageRank Pleine])[
  #fletcher.diagram(
    node-fill: rgb("aafa"),
    node-outset: 2pt,
    node((1, 0), `pagerank`, shape: "circle"),
    node((2, 1), `pagerank_pleine`),
    node((2.5, 0), `lire_graphe`),
    node((3, 1), `matrices_pleines`),
    node((3, -1), `matrices_creuses`),
    node((3, -2), `vecteurs_creux`),
    edge((1, 0), (2.5, 0), "->"),
    edge((2.5, 0), (3, 1), "-->"),
    edge((2.5, 0), (3, -1), "-->"),
    edge((3, -1), (3, -2), "-->"),
    edge((2, 1), (3, 1), "-->"),
    edge((1, 0), (2, 1), $#overline("Creuse")$, "->", bend: +20deg),
  )
  - Réalise l'algorithme PageRank sur une matrice pleine
]

#slide(title: [PageRank Pleine : détails])[
Itération de l'algorithme : produit vectoriel de $pi_k$ (`Poids`) et $G$.
// typstfmt::off
  #sourcecode[
    ```adb
for J in 1 .. N loop
    Resultat(J) := 0.0;
    for I in 1..N loop
        Resultat(J) := Resultat(J)+Poids(I)*G(I, J);
    end loop;
end loop;
return Resultat;
    ```
  ]
// typstfmt::on

]

#slide(title: [PageRank Creuse])[
#fletcher.diagram(
  node-fill: rgb("aafa"),
  node-outset: 2pt,
  node((1,0), `pagerank`,shape:"circle"),
  node((2,-1), `pagerank_creuse`),
  node((2,1), `pagerank_pleine`, ),

  node((2.5,0), `lire_graphe`, ),



  node((3,1), `matrices_pleines`, ),
  node((3,-1), `matrices_creuses`, ),


  node((3,-2), `vecteurs_creux` ),

  edge((1,0), (2.5,0),"->", ),


  edge((2.5,0),(3,1), "-->"),
  edge((2.5,0),(3,-1), "-->"),


  edge((3,-1),(3,-2), "-->"),


  edge((2,1),(3,1), "-->"),
  edge((2, -1),(3,-1), "-->"),

  edge((1,0), (2,-1), $"Creuse"$, "->", bend: -20deg, ),
  edge((1,0), (2,1),$#overline("Creuse")$, "->", bend: +20deg, )
)
]

#slide(title: [PageRank Creuse : détails])[
  Dans le cas Matrices Creuse, on parcourt les lignes avec un curseur.
// typstfmt::off
#sourcecode(```adb
for J in 1..Taille loop -- pour chaque colonne
    Resultat(J) := 0.0;
    Tete := S(J);
    for I in 1..Taille loop -- parcourir la ligne
        if Tete = Null then
            Tmp := 0.0;
        elsif Tete.Indice = I then
            Tmp := Tete.Valeur/Facteurs(I);
            Tete := Tete.Suivant;
        else
            while Tete /= Null and then Tete.Indice < I loop
                Tete := Tete.Suivant;
            end loop;
            Tmp := 0.0;
        end if;
        Resultat(J) := Resultat(J) + (Alpha * Tmp+ beta) * Poids(I);
    end loop;
end loop;
    ```)
// typstfmt::on
  On recrée la matrice $G$ directement dans les itérations dans la ligne 16.
]

#slide(title: [Idées d'amélioration])[
  - Données utiles : présence d'au moins un référencement et $F$ lui-même

  - Dans le cas Matrices Creuses, on peut remplacer $M$ par $tilde(M)$ :
    $ forall (i,j) in [|1,n|]^2, tilde(M)_(i,j) in {"Vrai", "Faux"} $
  - Motivations
    - `Long_Float` : $64$ bits
    - Booléen : $1$ bit
]