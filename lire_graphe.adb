with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

package body Lire_Graphe is
    procedure Completer_Graphe (File : in out Ada.Text_IO.File_Type; G : in out T_Matrice) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;
        begin
    	begin
		while not End_Of_file (File) loop
			Get (File, Entier_1);
            Get (File, Entier_2);

            Modifier_Element(G, Entier_1+1, Entier_2+1, Element(G, Entier_1+1, Entier_2+1)+1.0);

		end loop;
	exception
		when End_Error =>
			null;
			Put_Line ("[fin du fichier détectée sur exception]");
	end;

	Close (File);


    for I in 1.. Taille(G) loop
        Total :=0.0;
        for J in 1..Taille(G) loop
            Total := Total + Element(G,I,J);
        end loop;

        if Total >= 0.0001 then
            for J in 1..Taille(G) loop
                Modifier_Element(G,I,J,Element(G,I,J)/total);
            end loop;
        else
            null;
        end if;
    end loop;




    end Completer_Graphe;
end Lire_graphe;