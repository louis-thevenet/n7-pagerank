package PageRank is

    -- Applique l'algorithme PageRank sur un graphe orienté représenté dans le fichier Fichier_Nom.
    procedure Algorithme_PageRank(Alpha : in Long_Float;
                                    K : in Integer;
                                    Epsilon : in Long_Float;
                                    Pleine : in Boolean;
                                    Prefixe : in String;
                                    Fichier_Nom : in String);
end PageRank;