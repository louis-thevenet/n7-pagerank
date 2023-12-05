with Lire_Graphe;
generic
    Capacite : Integer;

package PageRank is
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