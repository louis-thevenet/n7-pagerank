with Matrice_Pleine;
with Lire_Graphe;

generic
    Capacite : Integer;

package PageRank is

package Matrices_Pleines is new Matrice_Pleine(Long_Float, Capacite); use Matrices_Pleines;
--package Matrices_Creuses is new Matrice_Creuse(Long_Float, Capacite); use Matrices_Creuses;

package Lire_Graphe_Pleine is new Lire_Graphe(Matrices_Pleines);
use Lire_Graphe_Pleine;

    procedure Algorithme_PageRank(alpha : in Long_Float;
                                    k : in Integer;
                                    epsilon : in Long_Float;
                                    creuse : in Boolean;
                                    Prefixe : in String;
                                    Fichier : in String);

private
    type T_Tab_Poids is array (1..Capacite) of Long_Float;
    type T_Tab_Indices is array (1..Capacite) of Integer;

    type T_Resultat is record
        Poids : T_Tab_Poids;
        Indices : T_Tab_Indices;
    end record;



end PageRank;