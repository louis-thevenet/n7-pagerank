with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Long_Float_Text_IO;           use Ada.Long_Float_Text_IO;


package body Matrices_Pleines is

    procedure Initialiser(M : out T_Matrice) is
    begin
    M.Taille := Taille;
        for I in 1..M.Taille loop
            for J in 1..M.Taille loop
                M.Mat(I,J):=0.0;
            end loop;
        end loop;
    end Initialiser;

    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float) is
    begin
        M.Mat(I,J):=Nouveau;
    end Modifier;

    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float is
    begin
        return M.Mat(I,J);
    end Element;

    procedure Afficher(M : T_Matrice) is
    begin
        for I in 1..M.Taille loop
            for J in 1..M.Taille loop
                Put(M.Mat(I,J));
                Put(" ");
            end loop;
                New_Line;
        end loop;
    end Afficher;

    function Taille_Matrice(M : T_Matrice) return Integer is
    begin
        return M.Taille;
    end Taille_Matrice;



end Matrices_Pleines;