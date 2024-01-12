#import "template.typ": *
#import "@preview/codelst:1.0.0": sourcecode
#import "@preview/fletcher:0.3.0" as fletcher:node, edge


#show: project.with(
  title: "Rapport projet PIM : PageRank ",
  authors: (
    "THEVENET Louis",
    "MORISSEAU Albin",
  ),
  subtitle : "Décembre 2023 - Janvier 2024" + linebreak() +"Groupe EF03",
)

// VIRER LE CODE D'ICI
#line(length: 100%, stroke: red + 0.5cm)
#line(length: 100%, stroke: red+0.5cm)
#line(length: 100%, stroke: red+0.5cm)
= A FAIRE
== Infos
/ Remise du rapport complet : Mardi
/ Remise du code, présentation et script : Mercredi
/ Présentation + démo : Jeudi

==  A faire
- virer fichiers d'exemples du gitlab si j'ai oublié
- finir raffinages (vérifier que ça colle avec le code (peu probable))
- Finir le rapport
  - faire les tests de temps
- faire présentation et script
#line(length: 100%, stroke: red+0.5cm)
#line(length: 100%, stroke: red+0.5cm)
#line(length: 100%, stroke: red+0.5cm)
// A ICI AVANT DE PUBLIER MDR


= Résumé du rapport
Ce rapport contient les éléments essentiels de la conception d’un programme défensif ayant pour but de mesurer la popularité des pages Internet. On envisage deux principales implantations de l’algorithme, par des tableaux simples puis en exploitant le fait que la matrice d'adjacence est très creuse.

Le choix des matrices creuses est beaucoup plus efficace en termes de complexité et devra être privilégié (valeur par défaut) d’autant plus si le graphe d’entrée possède de nombreux sommets.

Ce rapport contient l’architecture complète de l’application et des différents modules utilisés ainsi qu’un comparatif des performances des deux implantations.

= Introduction

Chaque jour, plus de 7 milliards de recherches sont effectuées via des moteurs de recherche soit presque 81000 par seconde. Chaque recherche peut renvoyer des millions de résultats. Ainsi, il est essentiel pour faciliter la vie des utilisateurs et minimiser les coûts, de trier ces différents résultats de la manière pertinente et efficace.

Ce projet consiste à implanter l’algorithme PageRank qui mesure la popularité de pages Internet en utilisant les référencements qui mènent d'une page à une autre.

On pourra choisir les différents paramètres de l’algorithme ainsi que l'implantation choisie lors de la saisie de la commande d'appel.

== Paramètres de la ligne de commande

/ -A : Le _Dumping Factor_ ($alpha$), est un paramètre de pondération, plus sa valeur approche $1$, plus la convergence est lente
/ -K : Le nombre d'itération ($k$) de l'algorithme à réaliser
/ -E : La précision ($epsilon$) permet d'intérompre l'algorithme lorsque la variation du vecteur poids d'une itération à l'autre lui est inférieure
/ -R : Le préfixe utilisé pour les fichiers de sortie (`<prefixe>.pr` et `<prefixe>.prw`)
/ -C : Permet de choisir la version matrices creuses
/ -P : Permet de choisir la version matrices pleines

== Valeurs par défaut des paramètres
Les paramètres du programme lorsque non spécifiés ont pour valeurs :
$ alpha &:= 0.85 \
k&:=150 \
epsilon &:= 0.0\
$

== Spécification des paramètres
Les paramètres doivent respecter certaines conditions pour que le programme execute l'algorithme :
$ alpha &in [0,1] \
epsilon &>=0 \
"Un seul algorithme" &"choisi (Creuse ou Pleine)" \
"Préfixe" &"non vide" $


= Architecture de l’application


#fletcher.diagram(
	node-fill: rgb("aafa"),
	node-outset: 2pt,
	node((0,0), `Programme Principal`),
	node((1,0), `pagerank`,shape:"circle"),
	node((2,-1), `pagerank_creuse`),
	node((2,1), `pagerank_pleine`, ),

	node((2.5,0), `lire_graphe`, ),


	node((0,-1), `pagerank_result`),

	node((3,1), `matrices_pleines`, ),
	node((3,-1), `matrices_creuses`, ),


	node((3,-2), `vecteurs_creux` ),


	edge((-1,0), (0,0), $"Début"$,"=>"),

	edge((0,0), (1,0), "->"),

	edge((1,0), (0,-1), "->"),

	edge((1,0), (2.5,0),"->", ),


	edge((2.5,0),(3,1), "-->"),
	edge((2.5,0),(3,-1), "-->"),


	edge((3,-1),(3,-2), "-->"),


	edge((2,1),(3,1), "-->"),
	edge((2, -1),(3,-1), "-->"),

	edge((1,0), (2,-1), $"Creuse"$, "->", bend: -20deg, ),
	edge((1,0), (2,1),$#overline("Creuse")$, "->", bend: +20deg, )
)

#underline("Légende") :
/ $arrow.double$ : point d'entrée
/ $arrow$ : _appelle_
/ $arrow.dashed$ : _utilise_

= Choix techniques / Structure de données
== Cas Matrices Pleines
#sourcecode()[
  ```adb
type T_Matrice_Pleine is array(1..N, 1..P) of Long_Float;

type T_Matrice is record
    Mat : T_Matrice_Pleine;
    Lignes : Integer;
    Colonnes : Integer;
end record;
    ```
]

== Cas Matrices Creuses
#sourcecode()[
  ```adb

-- matrices_creuses.adb
type T_Matrice is array(1..Taille) of T_Vecteur_Creux;
type T_Facteurs is array(1..Taille) of Long_Float;

-- vecteurs_creux.adb
type T_Cellule;
type T_Vecteur_Creux is access T_Cellule;

type T_Cellule is
  record
    Indice : Integer;
    Valeur : Long_Float;
    Suivant : T_Vecteur_Creux;
  end record;

    ```
]


= Performances des implantations

#table(columns: 3, [Fichier graphe Test], [Implantation Pleine], [Implantation Creuse],
[`sujet.net`], [],[],
[`worms.net`],[],[],
[`brainlinks.net`], [], []
)



= Difficultés rencontrées et solutions apportées
== Représentation par matrices creuses

Nous avons initialement choisi de réaliser un vecteurs creux de vecteurs creux mais les performances n'étaient pas très bonnes alors que l'implémentation était compliquée.

Nous avons ensuite choisi d'utiliser un tableau de vecteurs creux afin que l'opération d'accès aux têtes de colonnes se fasse en temps constant (les vecteurs représentent les colonnes).

= Répartition des tâches
 #table(columns: 5,
  [Modules],[Spécifier],[Programmer],[Tester],[Relire],
 [`programme_principal`], [A],[A],[A],[L],
 [`lire_graphe`],[A],[A],[A],[L],
 [`pagerank`],[A],[A],[A],[L],
 [`pagerank_creuse`],[L],[L],[L],[A],
 [`pagerank_pleine`],[L],[L],[L],[A],
 [`matrices_creuses`],[L],[L],[L],[A],
 [`matrices_pleines`],[L],[L],[L],[A],
 [`vecteurs_creux`],[A],[A],[A],[L],
 [`pagerank_result`],[A],[A],[A],[L],
)


= Conclusion et avancement

Nous avons réussi à implanter de manière robuste les deux versions de l'algorithme.

Nous avons pour perspective d’améliorer la précision de nos calculs de poids en introduisant un paramètre générique de précision dans nos différents programmes.

= Annexes :

Raffinages complets, Grilles d’auto évaluation : #link("https://typst.app/project/r6w1dcIWXsWDh_Cxu31_fl", "Raffinages projet Pagerank groupe EF03")
== Apport personnel du projet
/ Albin Morisseau: Ce projet, m’as permis de

/ Louis Thevenet : ...


