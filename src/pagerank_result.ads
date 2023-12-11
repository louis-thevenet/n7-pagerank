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

    procedure Initialiser(Resultat : in out T_Resultat);
    function Norme_Au_Carre(Poids : T_Tab_Poids) return Long_Float;
    function Combi_Lineaire(lambda : Long_Float; Poids : T_Tab_Poids; mu : Long_Float; Poids2 : T_Tab_Poids) return T_Tab_Poids;
    procedure Afficher(Resultat : T_Resultat);
    procedure Trier (Resultat : in out T_Resultat);
    procedure Enregistrer(Resultat : T_Resultat; Prefixe : String; Alpha : Long_Float; K : Integer);

end PageRank_Result;