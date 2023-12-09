with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Long_Float_Text_IO;           use Ada.Long_Float_Text_IO;


package body Matrices_Pleines is

    procedure Initialiser(M : out T_Matrice) is
    begin
    M.Lignes := N;
    M.Colonnes := P;
        for I in 1..M.Lignes loop
            for J in 1..M.Colonnes loop
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
        for I in 1..M.Lignes loop
            for J in 1..M.Colonnes loop
                Put(M.Mat(I,J), 1, 5, 0);
                Put(" ");
            end loop;
                New_Line;
        end loop;
    end Afficher;

    function Lignes_Matrice(M : T_Matrice) return Integer is
    begin
        return M.Lignes;
    end Lignes_Matrice;


    function Colonnes_Matrice(M : T_Matrice) return Integer is
    begin
        return M.Colonnes;
    end Colonnes_Matrice;

    function Norme_Au_Carre(M : T_Matrice) return Long_Float is
    Res : Long_Float;
    begin
    Res := 0.0;
    for I in 1..M.Lignes loop
        for J in 1..M.Colonnes loop
            Res := Res + M.Mat(I,J)*M.Mat(I,J);

        end loop;
    end loop;
    return Res;
    end Norme_Au_Carre;

    function Combi_Lineaire(Lambda : Long_Float; M : T_Matrice; Mu : Long_Float; N : T_Matrice) return T_Matrice is
    Res : T_Matrice;
    begin
        Initialiser(Res);
        for I in 1..M.Lignes loop
            for J in 1..M.Colonnes loop
                Res.Mat(I,J) := Lambda*M.Mat(I,J) + Mu*N.Mat(I,J);
            end loop;
        end loop;
        return Res;
    end Combi_Lineaire;

end Matrices_Pleines;