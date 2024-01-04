generic
    Taille : Integer;
package PageRank_Result is

    type T_Tab_Poids is array (1..Taille) of Long_Float;
    type T_Tab_Indices is array (1..Taille) of Integer;

    type T_Resultat is record
        Taille : Integer;
        Poids : T_Tab_Poids;
        Indices : T_Tab_Indices;
    end record;

    -- Initialiser le résultat de PageRank
    procedure Initialiser(Resultat : in out T_Resultat);

    -- Afficher le résultat de PageRank
    procedure Afficher(Resultat : T_Resultat);

    -- Trier le résultat de PageRank
    procedure Trier (Resultat : in out T_Resultat);

    -- Enregistrer le résultat de PageRank dans un fichier
    procedure Enregistrer(Resultat : T_Resultat; Prefixe : String; Alpha : Long_Float; K : Integer);

end PageRank_Result;