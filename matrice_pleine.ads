generic
    type T_Element is private;
    Capacite : Integer;

package Matrice_Pleine is

type T_Matrice is private;

procedure Initialiser_Matrice(M : in out T_Matrice; Valeur : T_Element);

generic
    with procedure Afficher(Elemenet : T_Element);
procedure Afficher_Matrice (M : in T_Matrice);
procedure Modifier_Element (M : in out T_Matrice; I :in Integer; J : in Integer; Nouveau : in T_Element);
function Element (M : in T_Matrice; I :in Integer; J : in Integer) return T_Element;

generic
with function Traitement(Element : T_Element) return T_Element;
procedure Applique (M : in out T_Matrice; I :in Integer; J : in Integer);
function Taille(M : in T_Matrice) return Integer;
private
    type T_Matrice_Elements is array (1..Capacite, 1..Capacite) of T_Element;

    type T_Matrice is record
        Mat : T_Matrice_Elements;
        Taille : Integer;
    end record;


end Matrice_Pleine;