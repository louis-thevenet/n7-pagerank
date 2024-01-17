with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
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


	function Composante (V : in T_Vecteur_Creux ; Indice : in Integer) return Boolean is
    tmp : T_Vecteur_Creux;
	begin
        tmp := V;
        While (True) loop
            if (Est_Nul(tmp)) then
                return False;
            elsif (tmp.All.Indice = Indice) then
                return True;
            elsif tmp.All.Indice > Indice then
                return False;
            end if;
            tmp:=tmp.All.Suivant;
        end loop;
        return False;
	end Composante;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer) is
tmp : T_Vecteur_Creux;
	begin
        if Est_Nul(V) then
                V := new T_Cellule;
                V.All.Indice := Indice;
                V.All.Suivant:=Null;

        elsif (Indice = V.All.Indice) then
                V := V.Suivant;

        elsif (Indice < V.All.Indice ) then
                tmp := new T_Cellule;
                tmp.All := V.All;

                V.All.Indice := Indice;
                V.All.Suivant := tmp;
        elsif Est_Nul(V.All.Suivant) then
                V.All.Suivant := new T_Cellule;
                V.All.Suivant.All.Indice := Indice;
                V.All.Suivant.All.Suivant:=Null;
        else
            Modifier(V.All.Suivant, Indice);
        end if;
	end Modifier;


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
            if (tmp.All.Indice = tmp2.All.Indice ) then
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
