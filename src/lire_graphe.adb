with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

package body Lire_Graphe is
    procedure Completer_Graphe (File : in out Ada.Text_IO.File_Type; H : in out Matrices.T_Matrice) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;
        begin
    	begin
		while not End_Of_file (File) loop
			Get (File, Entier_1);
            Get (File, Entier_2);

            Matrices.Modifier(H, Entier_1+1, Entier_2+1, Matrices.Element(H, Entier_1+1, Entier_2+1)+1.0);

		end loop;
	exception
		when End_Error =>
			null;
	end;

	Close (File);

    for I in 1.. Matrices.Taille_Matrice(H) loop
        Total :=0.0;
        for J in 1.. Matrices.Taille_Matrice(H)  loop
            Total := Total + Matrices.Element(H,I,J);
        end loop;

        if Total >= 0.00001 then
            for J in 1.. Matrices.Taille_Matrice(H) loop
                Matrices.Modifier(H,I,J,Matrices.Element(H,I,J)/total);
            end loop;
        else
            null;
        end if;
    end loop;




    end Completer_Graphe;
end Lire_graphe;