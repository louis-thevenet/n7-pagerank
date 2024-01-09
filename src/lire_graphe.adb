with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Vecteurs_Creux;
package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses_Inst.T_Matrice; Facteurs : in out Matrices_Creuses_Inst.T_Facteurs) is
        Entier_1, Entier_2 : Integer;
        Tmp : Matrices_Creuses_Inst.T_Matrice;
        Tmp2 : Long_Float;
        I : Integer;
        Taille_Float : Long_Float;
          begin

        for I in 1..N loop
            Facteurs(I):=0.0;
        end loop;

        begin
            Tmp := H;
            while not End_Of_file (File) loop
                Get (File, Entier_1);
                Get (File, Entier_2);
                Facteurs(Entier_1+1) := Facteurs(Entier_1+1)+1.0;
                Vecteurs_Creux.Incremente(H(Entier_2+1), Entier_1+1);
            end loop;
        exception
            when End_Error =>
                null;
        end;
	Close (File);
    Taille_Float := Long_Float(Facteurs'Length);
    for I in 1..Facteurs'Length loop
            if abs(Facteurs(I))<=0.00001 then
                for J in 1..Facteurs'Length loop
                    Vecteurs_Creux.Modifier(H(J), I, 1.0/Taille_Float);
                    Facteurs(I):=1.0;
                end loop;
            else
            null;
            end if;
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