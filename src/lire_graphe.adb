with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Vecteurs_Creux;			use Vecteurs_Creux;

package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses.T_Matrice; Taille:Integer) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;

        Tmp : Matrices_Creuses.T_Matrice;
        Tmp2 : T_Vecteur_Creux;


        begin
    	begin
		while not End_Of_file (File) loop
			Get (File, Entier_1);
            Get (File, Entier_2);

            Matrices_Creuses.Modifier(H, Entier_1+1, Entier_2+1, Matrices_Creuses.Element(H, Entier_1+1, Entier_2+1)+1.0);

		end loop;
	exception
		when End_Error =>
			null;
	end;

	Close (File);

    Tmp := H;

    while Tmp /= Null loop

        Total :=0.0;
        Tmp2 := Tmp.Valeur;
        while Tmp2 /= Null loop
            Total := Total + Tmp2.Valeur;
            Tmp2 := Tmp2.Suivant;
        end loop;

        if Total >= 0.000001 then
            Tmp2 := Tmp.Valeur;
            while Tmp2 /= Null loop
                Tmp2.Valeur := Tmp2.Valeur/total;
                Tmp2:=Tmp2.Suivant;
            end loop;
        else
            null;
        end if;
        Tmp := Tmp.Suivant;
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