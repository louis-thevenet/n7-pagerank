package body Lire_Graphe is
    type T_Element is Long_Float;
    package T_Matrice_Adj is new Matrice_Pleine(T_Element);
    package Lire_Graphe_Cap is new Lire_Graphe(T_Matrice_Adj, Capacite); use Lire_Graphe_Cap;

    function Creer_Graphe (Fichier : in String) return T_Graphe is
    G : T_Graphe;
    begin

        return G;
    end Creer_Graphe;
end Lire_graphe;