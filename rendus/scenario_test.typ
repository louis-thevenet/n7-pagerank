#import "template.typ": *
#import "@preview/codelst:1.0.0": sourcecode

#show: project.with(
  title: "Scénario de test : PageRank ",
  authors: ("THEVENET Louis", "MORISSEAU Albin",),
  subtitle: "Décembre 2023 - Janvier 2024" + linebreak() + "Groupe EF03",
  toc: false,
)

= Résumé du fichier

Ce fichier comporte un scénario de différents appels du programme pincipal de
notre algorithme Pagerank.

= Démonstration de la Robustesse

On utilise le fichier `worms.net`.

On teste des cas limites de l'appel de la ligne de commande avec des arguments
faux ou hors des bornes.

- $alpha <0$

  `./programme_principal -P -A -0.90 -K 20 output  worm.net`

  Vous devez respecter les conditions sur alpha

- $alpha >1$

  `./programme_principal -P -A 1.90 -K 20 -R output  worm.net`

  Vous devez respecter les conditions sur alpha

- $K<0$

  `./programme_principal -P -K -20 -R output  worm.net`

  Vous devez respecter les conditions sur k

- $epsilon <0$

  `./programme_principal -P -E -20 -R output  worm.net`

  Vous devez respecter les conditions sur Epsilon

- $"Creuse" = "Pleine"$

  `./programme_principal -P -C -R output  worm.net`

  Attention, vous ne pouvez pas activer à la fois le mode Creuse et à la fois le
  mode Pleine

- Mauvais fichier d'entrée `./programme_principal -P -R output
   mauvais_fichier_entree.net`

  Le fichier mauvais_fichier_entree.net n'existe pas

= Démonstration du respect du cahier des charges

On lance notre programme principal avec le fichier `sujet.net` :

`./programme_principal -R output  sujet.net`

`./programme_principal -R output -C  sujet.net`

On lance notre programme principal avec le fichier `worm.net`.

`./programme_principal -R output  worm.net`

`./programme_principal -R output -C  worm.net`

On lance notre programme principal avec le fichier `sujet.net` :

`./programme_principal -R output brainlinks.net`

`./programme_principal -R output -C brainlinks.net`

