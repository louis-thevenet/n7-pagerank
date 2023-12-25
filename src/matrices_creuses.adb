with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;		use Ada.Long_Float_Text_IO;
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
        M.Indice := J;
        M.Suivant := Null;
        M.Precedent := Null;
        Vecteurs_Creux.Initialiser(M.Valeur);
        Vecteurs_Creux.Modifier(M.Valeur, I, Nouveau);
    elsif
        M.Indice = J then
            Vecteurs_Creux.Modifier(M.Valeur, I, Nouveau);
    elsif J < M.Indice then
        tmp := new T_Cellule_Matrice;
        tmp.All := M.All;

        M.Indice := J;

        Vecteurs_Creux.Initialiser(M.Valeur);
        Vecteurs_Creux.Modifier(M.Valeur, I, Nouveau);
        M.Suivant := tmp;
        tmp.Precedent := M;
    elsif M.Suivant = Null then
        M.Suivant := new T_Cellule_Matrice;
        M.Suivant.Indice := J;
        M.Suivant.Suivant := Null;
        M.Suivant.Precedent := M;
        Vecteurs_Creux.Initialiser(M.Suivant.Valeur);
        Vecteurs_Creux.Modifier(M.Suivant.Valeur, I, Nouveau);
    else
        Modifier(M.Suivant, I, J, Nouveau);
    end if;
end Modifier;

function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float is
begin
    if M = Null or else M.Indice > J then
        return 0.0;
    elsif M.Indice = J then
        return Vecteurs_Creux.Composante_Iteratif(M.Valeur, I);
    else
        return Element(M.Suivant, I, J);
    end if;
end Element;

procedure Afficher(M : T_Matrice) is
begin
    for i in 1..6 loop
        for j in 1..6 loop
            Put(Element(M, i, j), 1,3,0);
            Put(" | ");
        end loop;
        new_line;
    end loop;
    --  if M = Null then
    --      Put("--end matrice--");
    --  else
    --      new_line;
    --      Put("Colonne : ");
    --      Put(M.Indice, 1);
    --      Put(" : ");
    --      Vecteurs_Creux.Afficher(M.Valeur);
    --      Put_Line("");
    --      Afficher(M.Suivant);
    --  end if;
end Afficher;

--  procedure Pour_Chaque(M : in out T_Matrice) is
--  Tmp : T_Matrice;
--  Tmp2 : T_Vecteur_Creux;
--  begin
--      Tmp := M;
--      while tmp /= Null loop
--          Tmp2 := M.Valeur;
--          while Tmp2 /= Null loop
--              --Tmp2.Valeur := Traitement(Tmp2.Valeur);
--              Tmp2 := Tmp2.Suivant;
--          end loop;
--          Tmp := Tmp.Suivant;
--      end loop;
--  end Pour_Chaque;

end Matrices_Creuses;