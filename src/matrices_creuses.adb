with Ada.Text_IO;			use Ada.Text_IO;

package body Matrices_Creuses is

procedure Initialiser(M : out T_Matrice) is
begin
    M.Lignes :=N;
    for I in 1..N loop
        Vecteurs_Creux.Initialiser(M.Mat(I));
    end loop;
end Initialiser;

procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float) is
begin
    Vecteurs_Creux.Modifier(M.Mat(I), J, Nouveau);
end Modifier;

function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float is
begin
    return Composante_Recursif(M.Mat(I), J);
end Element;

procedure Afficher(M : T_Matrice) is
begin
    for I in 1..M.Lignes loop
        Vecteurs_Creux.Afficher(M.Mat(I));
        New_Line;
    end loop;
end Afficher;

function Lignes_Matrice(M : T_Matrice) return Integer is
begin
    return M.Lignes;
end Lignes_Matrice;

function Colonnes_Matrice(M:T_Matrice) return Integer is
begin
return M.Colonnes;
end Colonnes_Matrice;

end Matrices_Creuses;