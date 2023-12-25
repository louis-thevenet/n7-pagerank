with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Vecteurs_Creux;			use Vecteurs_Creux;

package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses.T_Matrice; Lignes_Non_Nulles : in out T_Vecteur_Creux; Taille:Integer) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;
        Tmp : Matrices_Creuses.T_Matrice;
        Tete_Lignes_Non_Nulles : T_Vecteur_Creux;
        Tmp2 : Long_Float;
        I : Integer;
        begin
        begin
            Tmp := H;
            I:=0;
            while not End_Of_file (File) loop
                Get (File, Entier_1);
                Get (File, Entier_2);
                Vecteurs_Creux.Incremente(Lignes_Non_Nulles, Entier_1+1);

                while Tmp /= Null and then Tmp.Precedent /= Null and then Tmp.Indice > Entier_2+1 loop
                    Tmp := Tmp.Precedent;
                end loop;

                while Tmp /= Null and then Tmp.Suivant /= Null and then Tmp.Indice < Entier_2+1 loop
                    Tmp := Tmp.Suivant;
                end loop;
                if Tmp /= Null then
                    Matrices_Creuses.Modifier(Tmp, Entier_1+1, Entier_2+1, 1.0);
                else
                    Matrices_Creuses.Modifier(H, Entier_1+1, Entier_2+1, 1.0);
                    Tmp := H;
                end if;
            end loop;
        exception
            when End_Error =>
                null;
        end;
	Close (File);
    I := 1;
    Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;
    while Tete_Lignes_Non_Nulles /= Null loop
        Tmp := H;
        if Tete_Lignes_Non_Nulles.Indice /= I then
            for J in 1.. Taille loop
                Matrices_Creuses.Modifier(Tmp, I, J, 1.0/Long_Float(Taille));
                if Tmp.Indice < J then -- Tmp != null ici
                    Tmp := Tmp.Suivant;
                end if;
            end loop;
        else
            Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
        end if;
        I := I+1;
    end loop;
end Completer_Graphe_Creuse;

        procedure Completer_Graphe_Pleine (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Pleines_Inst.T_Matrice) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;
        begin
    	begin
		while not End_Of_file (File) loop
			Get (File, Entier_1);
            Get (File, Entier_2);

            Matrices_Pleines_Inst.Modifier(H, Entier_1+1, Entier_2+1, Matrices_Pleines_Inst.Element(H, Entier_1+1, Entier_2+1)+1.0);

		end loop;
	exception
		when End_Error =>
			null;
	end;

	Close (File);

    for I in 1.. Matrices_Pleines_Inst.Lignes_Matrice(H) loop
        Total :=0.0;
        for J in 1.. Matrices_Pleines_Inst.Colonnes_Matrice(H)  loop
            Total := Total + Matrices_Pleines_Inst.Element(H,I,J);
        end loop;

        if Total >= 0.000001 then
            for J in 1.. Matrices_Pleines_Inst.Colonnes_Matrice(H) loop
                Matrices_Pleines_Inst.Modifier(H,I,J,Matrices_Pleines_Inst.Element(H,I,J)/total);
            end loop;
        else
            null;
        end if;
    end loop;
    end Completer_Graphe_Pleine;
end Lire_graphe;