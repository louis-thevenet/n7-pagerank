generic
    N : Integer;
    P : Integer;
package Matrices_Pleines is

    type T_Matrice is private;

    procedure Initialiser(M : out T_Matrice);
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;
    procedure Afficher(M : T_Matrice);
    function Lignes_Matrice(M : T_Matrice) return Integer;
    function Colonnes_Matrice(M : T_Matrice) return Integer;
private
    type T_Matrice_Pleine is array(1..N, 1..P) of Long_Float;
    type T_Matrice is record
        Mat : T_Matrice_Pleine;
        Lignes : Integer;
        Colonnes : Integer;
    end record;


end Matrices_Pleines;