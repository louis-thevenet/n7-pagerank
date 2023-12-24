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
    procedure Update_Dessus(M : in out T_Matrice; I : Integer; J : Integer; Ancien : T_Vecteur_Creux; Nouveau : T_Vecteur_Creux) is
    begin
        null;
    end Update_Dessus;

    procedure Interne(Tmp : in out T_Matrice; I : Integer; J : Integer;  Nouveau : Long_Float; Totale : T_Matrice) is
    Tmp_Cell : T_Matrice;
    Tmp_Vec : T_Vecteur_Creux;
    begin
        if Tmp=Null then
            Tmp := new T_Cellule_Matrice;
            Tmp.Indice := I;
            Tmp.Suivant := Null;
            Vecteurs_Creux.Initialiser(Tmp.Valeur);
            Vecteurs_Creux.Modifier(Tmp.Valeur, J, Nouveau, Null);
        elsif
            Tmp.Indice = I then
                Tmp_Vec := Plus_Bas_Maillon(Totale,  I, J);

                if Tmp_Vec = Null then
                    Vecteurs_Creux.Modifier(Tmp.Valeur, J, Nouveau, Plus_Haut_Maillon(Tmp, I, J));
                else
                    Vecteurs_Creux.Modifier(Tmp.Valeur, J, Nouveau, Tmp_Vec.Dessous);
                   Tmp_Vec.Dessous := Maillon(Tmp.Valeur, J);
                end if;
        elsif I < Tmp.Indice then

            Tmp_Cell := new T_Cellule_Matrice;
            Tmp_Cell.All := Tmp.All;
            Tmp.Indice := I;

            Vecteurs_Creux.Initialiser(Tmp.Valeur);
--
            Tmp_Vec := Plus_Haut_Maillon(Totale, I, J);
            if Tmp_Vec = Null then
                put(I);
                new_line;
                put(J);
                new_line;
                new_line;
                end if;

--
            Tmp.Suivant := Tmp_Cell;
            Vecteurs_Creux.Modifier(Tmp.Valeur, J, Nouveau, Plus_Haut_Maillon(Totale, I, J));

            Tmp_Vec := Plus_Bas_Maillon(Totale, I, J);
            if Tmp_Vec=Null then
                null;
            else
                Tmp_Vec.Dessous := Tmp_Cell.Valeur;
            end if;

        elsif Tmp.Suivant = Null then
            Tmp.Suivant := new T_Cellule_Matrice;
            Tmp.Suivant.Indice := I;
            Tmp.Suivant.Suivant := Null;
            Vecteurs_Creux.Initialiser(Tmp.Suivant.Valeur);
            Vecteurs_Creux.Modifier(Tmp.Suivant.Valeur, J, Nouveau);

            Tmp_Vec := Plus_Bas_Maillon(Totale, I, J);
            if Tmp_Vec=Null then
                null;
            else
                Tmp_Vec.Dessous := Tmp.Suivant.Valeur;
            end if;
        else
            Interne(Tmp.Suivant, I, J, Nouveau, Totale);
        end if;
    end Interne;

begin
    Interne(M, I, J, Nouveau, M);
end Modifier;

function Plus_Bas_Maillon(M : T_Matrice; I : Integer; J : Integer) return T_Vecteur_Creux is
Tmp : T_Matrice;
Tmp_Colonne : T_Vecteur_Creux;
begin
Tmp := M;
    if M = Null then
        return Null;

    elsif M.Indice < I then
        Tmp_Colonne := Plus_Bas_Maillon(M.Suivant, I, J);
        if Tmp_Colonne = Null then
            Tmp_Colonne := Tmp.Valeur;
            while Tmp_Colonne /= Null and then Tmp_Colonne.Indice < J loop
                Tmp_Colonne := Tmp_Colonne.Suivant;
            end loop;
            if Tmp_Colonne = Null then
                return Null;
            elsif Tmp_Colonne.Indice > J then
                return null;
            else
                return Tmp_Colonne;
            end if;
        else
            return Tmp_Colonne;
        end if;
    else
        return Null;
    end if;
end Plus_Bas_Maillon;

function Plus_Haut_Maillon(M : T_Matrice; I : Integer; J : Integer) return T_Vecteur_Creux is
Tmp : T_Matrice;
Tmp_Colonne : T_Vecteur_Creux;
begin
Tmp := M;
    if M = Null then
        return Null;
    elsif
        M.Indice > I then
            Tmp_Colonne := M.Valeur;
            while Tmp_Colonne /= Null and then Tmp_Colonne.Indice < J loop
            Tmp_Colonne := Tmp_Colonne.Suivant;
            end loop;
            if Tmp_Colonne = Null or else Tmp_Colonne.Indice > J then
                return Plus_Haut_Maillon(M.Suivant, I, J);
            else
                return Tmp_Colonne;
            end if;
    else
        return Plus_Haut_Maillon(M.Suivant, I, J);
    end if;
end Plus_Haut_Maillon;


function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float is
begin
    if M = Null or else M.Indice > I then
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