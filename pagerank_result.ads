generic
    Taille : Integer;
package PageRank_Result is



    type T_Tab_Poids is array (1..Taille) of Long_Float;
    type T_Tab_Indices is array (1..Taille) of Integer;

    type T_Resultat is record
        Poids : T_Tab_Poids;
        Indices : T_Tab_Indices;
    end record;
end PageRank_Result;