#import "template.typ": *
#import "@preview/fletcher:0.3.0" as fletcher:node, edge
#import "@preview/codelst:1.0.0": sourcecode

#show: project.with(
  title: "Rapport projet PIM : PageRank ",
  authors: ("THEVENET Louis", "MORISSEAU Albin",),
  subtitle: "Décembre 2023 - Janvier 2024" + linebreak() + "Groupe EF03",
)

// = Infos
// / Remise du rapport complet : Mardi
// / Remise du code, présentation et script : Mercredi
// / Présentation + démo : Mercredi

= Résumé du rapport
Ce rapport contient les éléments essentiels de la conception d’un programme
défensif ayant pour but de mesurer la popularité des pages Internet. On envisage
deux principales implantations de l’algorithme, par des matrices pleines puis
avec des matrices creuses en exploitant le fait que la matrice d'adjacence elle
même est très creuse.

Le choix des matrices creuses est beaucoup plus efficace en termes de complexité
et devra être privilégié (valeur par défaut) d’autant plus si le graphe d’entrée
possède de nombreux sommets.

Ce rapport contient, une introduction au principe de l'algorithme Pagerank,
l’architecture complète de l’application et des différents modules utilisés
ainsi qu’un comparatif des performances des deux implantations.

= Introduction

Chaque jour, plus de 7 milliards de recherches sont effectuées via des moteurs
de recherche soit presque 81000 par seconde. Chaque recherche peut renvoyer des
millions de résultats. Ainsi, il est essentiel pour faciliter la vie des
utilisateurs et minimiser les coûts, de trier ces différents résultats de la
manière la plus pertinente et efficace possible.

Ce projet consiste à implanter l’algorithme PageRank qui mesure la popularité de
pages Internet en utilisant les référencements qui mènent d'une page à une
autre. La formule suivante traduit le mecanisme récursif du calcul du poids ( en
terme de référencement) de chaque page:

$ r_(k+1) (P_i) = sum_(P_j in P^("IN")_i) (r_k (P_j)) / abs(P_j) $

Avec :

- $P_i$ : une page internet repr ́esent ́ee par un sommet du graphe

- $r_k(P_j )$ : le poids de la page $j$ à l’itération $k$

- $abs(P_j)$ : le nombre d’hyperliens de la page $P_j$

- $P_i^(op("IN"))$ : l’ensemble des pages qui référencent $P_i$

- $r_(k+1)(P_i)$ : le poids de la page $P_i$ à l’itération $k + 1$

Le calcul est initialisé avec pour chaque sommet $r_0(P_i) = 1/N$ où $N$ est le
nombre de pages web à classer. On arrête le calcul lorsque les valeurs
successives de deux poids est suffisamment proche, i.e $r_(k+1)(P_i) − r_k(P_i) < epsilon$,
avec $epsilon > 0$. On aura alors convergé vers la valeur $r(P_i)$ du poids de
la page. En la pratique, le calcul de tous les poids des pages webs au rang k +
1 est effectu ́e par une multiplication matricielle :

$ pi^T_(k+1) = pi^T_k times G $

$ pi^T_0 = (1/N, 1/N, ..., 1/N) in RR^NN $

Avec :

- $ pi^T_k = (r(P_0)_k, ..., r(P_i)_k, ..., /r(P_(N-)1)_k)$ : est un vecteur ligne
  dont la composante i est le poids de la page Pi au rang k.

- $G$ : est la matrice de Google, définie comme suit:

  $ G = alpha · S +(1 − alpha)/N*e times e^T $

où $e$·$e^T$ est une matrice carreé de taille N remplie de un et la matrice S
est une matrice d’adjacence pondérée qui comporte sur chaque ligne i la valeur
1/|$P_i$|, s’il existe au moins un lien sortant de la page $P_i$ vers la page $P_j$ ,
ou 1/N sur toute la ligne si le sommet $P_i$ n’a aucun lien sortant.

On pourra choisir les différents paramètres de l’algorithme ainsi que
l'implantation choisie lors de la saisie de la commande d'appel.

== Paramètres de la ligne de commande

/ -A: Le _Dumping Factor_ ($alpha$), est un paramètre de pondération, plus sa valeur
  approche $1$, plus la convergence est lente
/ -K: Le nombre d'itération ($k$) de l'algorithme à réaliser
/ -E: La précision ($epsilon$) permet d'intérompre l'algorithme lorsque la variation
  du vecteur poids d'une itération à l'autre lui est inférieure
/ -R: Le préfixe utilisé pour les fichiers de sortie (`<prefixe>.pr` et
  `<prefixe>.prw`)
/ -C: Permet de choisir la version matrices creuses
/ -P: Permet de choisir la version matrices pleines

== Valeurs par défaut des paramètres
Les paramètres du programme lorsque non spécifiés ont pour valeurs :
$ alpha &:= 0.85 \
k&:=150 \
epsilon &:= 0.0\
$

== Spécification des paramètres
Les paramètres doivent respecter certaines conditions pour que le programme
execute l'algorithme :
$ alpha &in [0,1]
epsilon &>=0 $
#align(center, [
  Un seul algorithme choisi (Creuse ou Pleine)
])
#align(center, [
  Préfixe non vide
])

= Architecture de l’application
#fletcher.diagram(
  node-fill: rgb("aafa"),
  node-outset: 2pt,
  node((0, 0), `Programme Principal`),
  node((1, 0), `pagerank`, shape: "circle"),
  node((2, -1), `pagerank_creuse`),
  node((2, 1), `pagerank_pleine`),
  node((2.5, 0), `lire_graphe`),
  node((0, -1), `pagerank_result`),
  node((3, 1), `matrices_pleines`),
  node((3, -1), `matrices_creuses`),
  node((3, -2), `vecteurs_creux`),
  edge((-1, 0), (0, 0), $"Début"$, "=>"),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (0, -1), "->"),
  edge((1, 0), (2.5, 0), "->"),
  edge((2.5, 0), (3, 1), "-->"),
  edge((2.5, 0), (3, -1), "-->"),
  edge((3, -1), (3, -2), "-->"),
  edge((2, 1), (3, 1), "-->"),
  edge((2, -1), (3, -1), "-->"),
  edge((1, 0), (2, -1), $"Creuse"$, "->", bend: -20deg),
  edge((1, 0), (2, 1), $#overline("Creuse")$, "->", bend: +20deg),
)

#underline("Légende") :
/ $arrow.double$ : point d'entrée
/ $arrow$ : _appelle_
/ $arrow.dashed$ : _utilise_

= Choix techniques / Structure de données
== Cas Matrices Pleines
// typstfmt::off
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
// typstfmt::on

== Cas Matrices Creuses
// typstfmt::off
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
// typstfmt::on

== Paramètre de généricité
=== Pour Matrice pleine
// typstfmt::off
#sourcecode()[
  ```adb
-- matrices_pleines.ads
generic
    N : Integer; -- Nombre de lignes
    P : Integer; --  Nombre de Colonnes
    ```
  ]
// typstfmt::on
=== Pour Matrice creuse
// typstfmt::off
#sourcecode()[
  ```adb
-- matrices_creuses.ads
generic
    Taille: Integer; -- Nombre de colonnes ( vecteurs creux)
    ```
  ]
// typstfmt::on
== Choix du tri


Nous avons choisi de trier notre vecteur résultat avec un tri par insertion. Ce n'est certes pas le plus efficace en terme de complexité mais cela était plus simple à coder. Cela fera partie des micro optimisation à réaliser plus tard.




= Performances des implantations

#table(columns: 3, [Fichier graphe Test], [Implant. Pleine (s)], [Implant. Creuse (s)],
[`sujet.net`], [0.009],[0.005],
[`worms.net`],[0.100],[0.103],
[`brainlinks.net`], [#eval("5*60+8.970")], [#eval("1*60+24.833")],
[`linux26.net`], [Stack overflow], [Stack overflow]
)

On observe que l'implantation en matrice creuse est plus eficcace en terme de complexité de calcul que celle en matrice pleine et ce d'autant plus si le graphe possède de nombreux sommets comme cela est le cas en conditions réelles. En effet, en prenant en compte l'aspect creuse de la matrice, on se dédouane de calculs inutiles.

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

Nous aurions également voulu tester une autre idée si le temps nous l'avait permis. Dans la version matrices creuses, avec l'utilisation du vecteur `Facteurs`, nous avons remarqué qu'il devenait inutile de stocker des valeurs dans la matrice : il suffit de _marquer_ les cases. Ainsi, il serait possible d'utiliser une matrice de booléens. On stockerait alors seulement des bits au lieu de `Long_Float` dont la taille est #link("https://sites.radford.edu/~nokie/classes/320/fundamentals/fundTypes.html", "64 bits")

= Annexes :

Raffinages complets, Grilles d’auto évaluation : #link("https://typst.app/project/r6w1dcIWXsWDh_Cxu31_fl", "Raffinages projet Pagerank groupe EF03")
== Apport personnel du projet

/ Albin Morisseau:
Ce projet, m’a permis de mieux appréhender la mise en place d'un projet plus conséquent, notamment l'importance de l'architecture des différents modules lors de sa conception. J'ai aussi appris à travailler en groupe et à coopérer malgré les méthodes et outils de travail différents. Ce projet a été enrichisant car j'ai beaucoup appris en travaillant avec Louis.

/ Louis Thevenet :
Dans ce projet, j'ai pu apprendre la gestion de différents modules (génériques) et leurs liens.

