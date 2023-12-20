with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;
package body Matrices_Creuses is

	-- procedure Free is new Ada.Unchecked_Deallocation (T_Matrice,T_Cellule_Matrice);

procedure Initialiser(M : out T_Matrice) is
begin
    M:= Null;
end Initialiser;

procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float) is
tmp : T_Matrice;
begin
    if M=Null then
        M := new T_Cellule_Matrice;
        M.Indice := I;
        M.Suivant := Null;
        Vecteurs_Creux.Initialiser(M.Valeur);
        Vecteurs_Creux.Modifier(M.Valeur, J, Nouveau);
    elsif
        M.Indice = I then
            Vecteurs_Creux.Modifier(M.Valeur, J, Nouveau);
    elsif I < M.Indice then
        tmp := new T_Cellule_Matrice;
        tmp.All := M.All;

        M.Indice := I;

        Vecteurs_Creux.Initialiser(M.Valeur);
        Vecteurs_Creux.Modifier(M.Valeur, J, Nouveau);
        M.Suivant := tmp;
    elsif M.Suivant = Null then
        M.Suivant := new T_Cellule_Matrice;
        M.Suivant.Indice := I;
        M.Suivant.Suivant := Null;
        Vecteurs_Creux.Initialiser(M.Suivant.Valeur);
        Vecteurs_Creux.Modifier(M.Suivant.Valeur, J, Nouveau);
    else
        Modifier(M.Suivant, I, J, Nouveau);
    end if;
end Modifier;

function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float is
begin
    if M = Null then
        return 0.0;
    elsif M.Indice = I then
        return Vecteurs_Creux.Composante_Iteratif(M.Valeur, J);
    else
        return Element(M.Suivant, I, J);
    end if;
end Element;

procedure Afficher(M : T_Matrice) is
begin
    if M = Null then
        Put("--end matrice--");
    else
        Put(M.Indice);
        Put(" : ");
        Vecteurs_Creux.Afficher(M.Valeur);
        Put_Line("");
        Afficher(M.Suivant);
    end if;
end Afficher;

--  function Lignes_Matrice(M : T_Matrice) return Integer is
--  begin
--  return 0;

--  end Lignes_Matrice;

--  function Colonnes_Matrice(M:T_Matrice) return Integer is
--  begin
--  return 0;
--  end Colonnes_Matrice;

end Matrices_Creuses;