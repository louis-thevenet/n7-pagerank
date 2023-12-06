generic
    Taille : Integer;
package Matrices_Pleines is

    type T_Matrice is private;

    procedure Initialiser(M : out T_Matrice);
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;
    procedure Afficher(M : T_Matrice);
    function Taille_Matrice(M : T_Matrice) return Integer;
private
    type T_Matrice_Pleine is array(1..Taille+1, 1..Taille+1) of Long_Float;
    type T_Matrice is record
        Mat : T_Matrice_Pleine;
        Taille : Integer;
    end record;


end Matrices_Pleines;