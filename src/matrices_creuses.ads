with Vecteurs_Creux; use Vecteurs_Creux;

generic
    N : Integer;
package Matrices_Creuses is

    type T_Matrice is limited private;

    procedure Initialiser(M : out T_Matrice);
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;
    procedure Afficher(M : T_Matrice);
    function Lignes_Matrice(M : T_Matrice) return Integer;
    function Colonnes_Matrice(M : T_Matrice) return Integer;

private
    type T_Matrice_Creuse is array(1..N+1) of T_Vecteur_Creux;
    type T_Matrice is record
        Mat : T_Matrice_Creuse;
        Lignes : Integer;
        Colonnes : Integer;
    end record;


end Matrices_Creuses;