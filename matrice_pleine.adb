with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

package body Matrice_Pleine is
    procedure Initialiser_Matrice(M : in out T_Matrice; Valeur : T_Element) is
    begin
        M.Taille := Capacite;
        for I in 1.. M.Taille loop
            for J in 1.. M.Taille loop
                M.Mat(I,J) := Valeur;
            end loop;
        end loop;
    end Initialiser_Matrice;

    procedure Afficher_Matrice (M : in T_Matrice) is
    begin
        Put(M.Taille);
        New_Line;
        New_Line;
        New_Line;
        for I in 1.. M.Taille loop
            for J in 1.. M.Taille loop
                Afficher(M.Mat(I,J));
                Put(" ");
            end loop;
            New_Line;
        end loop;
    end Afficher_Matrice;

procedure Modifier_Element (M : in out T_Matrice; I :in Integer; J : in Integer; Nouveau : in T_Element) is
begin
    M.Mat(I,J) := Nouveau;
end Modifier_Element;

function Element (M : T_Matrice; I :in Integer; J : in Integer) return T_Element is

begin
    return M.Mat(I,J);
end Element;

procedure Applique (M : in out T_Matrice; I :in Integer; J : in Integer) is
begin
    M.Mat(I,J) := Traitement(M.Mat(I,J));
end Applique;
function Taille(M : in T_Matrice) return Integer is begin return M.Taille; end Taille;
end Matrice_Pleine;
