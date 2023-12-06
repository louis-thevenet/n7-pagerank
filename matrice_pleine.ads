generic
    type T_Element is private;
    Capacite : Integer;

package Matrice_Pleine is

procedure Initialiser_Matrice(M : T_Matrice);
private
    type T_Matrice_Elements is array (1..Capacite+1, 1..Capacite+1) of T_Element;

    type T_Matrice is record
        Adj : T_Matrice_Elements;
        Taille : Integer;
    end record;


end Matrice_Pleine;