generic
   with package Matrices_Gen is new Matrices;

package Lire_Graphe is

type T_Graphe is private;
function Creer_Graphe (Fichier : in String) return T_Graphe;

private
    type T_Graphe is record
        Adj : T_Matrice_Adj;
        Taille : Integer;
    end record;

end Lire_Graphe;