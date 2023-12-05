package body PageRank is
    procedure Algorithme_PageRank(alpha : in Long_Float;
                                    k : in Integer;
                                    epsilon : in Long_Float;
                                    creuse : in Boolean;
                                    Prefixe : in String;
                                    Fichier : in String) is
    G : T_Graphe;
    begin
        G := Creer_Graphe(Fichier);
    end Algorithme_PageRank;



end PageRank;