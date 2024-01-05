with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;           use Ada.Long_Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
        V := Null;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
        if Est_Nul(V) then
            return;
        else
            Detruire(V.All.Suivant);
            Free(V);
        end if;
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return V=Null;
    end Est_Nul;


	function Composante (V : in T_Vecteur_Creux ; Indice : in Integer) return Long_Float is
    tmp : T_Vecteur_Creux;
	begin
        tmp := V;
        While (True) loop
            if (Est_Nul(tmp)) then
                return 0.0;
            elsif (tmp.All.Indice = Indice) then
                return tmp.All.Valeur;
            elsif tmp.All.Indice > Indice then
                return 0.0;
            end if;
            tmp:=tmp.All.Suivant;
        end loop;
        return 0.0;
	end Composante;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
					   Valeur : in Long_Float ) is
tmp : T_Vecteur_Creux;
	begin
        if Est_Nul(V) then
            if abs(Valeur) > 0.00001 then
                V := new T_Cellule;
                V.All.Indice := Indice;
                V.All.Valeur :=Valeur;
                V.All.Suivant:=Null;
            else
                null;
            end if;

        elsif (Indice = V.All.Indice) then
            if abs(Valeur) > 0.000001 then
                V.All.Valeur := Valeur;
            else
                V := V.Suivant;
            end if;

        elsif (Indice < V.All.Indice ) then
            if abs(Valeur) > 0.000001 then
                tmp := new T_Cellule;
                tmp.All := V.All;

                V.All.Indice := Indice;
                V.All.Valeur := Valeur;
                V.All.Suivant := tmp;
            else
                null;
            end if;
        elsif Est_Nul(V.All.Suivant) then
            if abs(Valeur) > 0.000001 then
                V.All.Suivant := new T_Cellule;
                V.All.Suivant.All.Indice := Indice;
                V.All.Suivant.All.Valeur :=Valeur;
                V.All.Suivant.All.Suivant:=Null;
            else
                null;
            end if;
        else
            Modifier(V.All.Suivant, Indice, Valeur);
        end if;
	end Modifier;

    procedure Incremente(V : in out T_Vecteur_Creux; Indice : in Integer ) is
        tmp : T_Vecteur_Creux;
    begin
        if Est_Nul(V) then
            V := new T_Cellule;
            V.All.Indice := Indice;
            V.All.Valeur :=1.0;
            V.All.Suivant:=Null;


        elsif (Indice = V.All.Indice) then
            V.All.Valeur := V.All.Valeur+1.0;

        elsif (Indice < V.All.Indice ) then

            tmp := new T_Cellule;
            tmp.All := V.All;

            V.All.Indice := Indice;
            V.All.Valeur := 1.0;
            V.All.Suivant := tmp;

        elsif Est_Nul(V.All.Suivant) then
            V.All.Suivant := new T_Cellule;
            V.All.Suivant.All.Indice := Indice;
            V.All.Suivant.All.Valeur :=1.0;
            V.All.Suivant.All.Suivant:=Null;

        else
            Incremente(V.All.Suivant, Indice);
        end if;
    end Incremente;

procedure Divise(V : in T_Vecteur_Creux; Indice : in Integer; Diviseur : in Long_Float ) is
tmp : T_Vecteur_Creux;
begin
        if Est_Nul(V) then
            null;


        elsif (Indice = V.All.Indice) then
            V.All.Valeur := V.All.Valeur/Diviseur;

        elsif (Indice < V.All.Indice ) then

            null;

        elsif Est_Nul(V.All.Suivant) then
            null;

        else
            Divise(V.All.Suivant, Indice, Diviseur);
        end if;
end Divise;

	function Sont_Egaux (V1, V2 : in T_Vecteur_Creux) return Boolean is

    tmp, tmp2 : T_Vecteur_Creux;
	begin
        tmp := V1;
        tmp2 := V2;
        While (True) loop
            if (Est_Nul(tmp) xor Est_Nul(tmp2)) then
                return false;
            elsif (Est_Nul(tmp) and Est_Nul(tmp2)) then
                return true;
            end if;
            if (tmp.All.Indice = tmp2.All.Indice  and then tmp.All.Valeur=tmp2.All.Valeur) then
                tmp := tmp.All.Suivant;
                tmp2:=tmp2.All.Suivant;
            else
                return false;
            end if;
        end loop;
        return false; -- n'arrive jamais
	end Sont_Egaux;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			-- Afficher la composante V.all
			Put ("-->[ ");
			Put (V.all.Indice, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");

			-- Afficher les autres composantes
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


    function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;

end Vecteurs_Creux;
