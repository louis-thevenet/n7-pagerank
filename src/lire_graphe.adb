with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Vecteurs_Creux;
package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses_Inst.T_Matrice; Facteurs : in out Matrices_Creuses_Inst.T_Facteurs) is
        Entier_1, Entier_2 : Integer;
        Taille_Float : Long_Float;
        Donnee_Error_negative : exception;
        Donnee_Error_taille : exception;
    begin

        for I in 1..N loop
            Facteurs(I):=0.0;
        end loop;

        begin
            while not End_Of_file (File) loop
                Get (File, Entier_1);
                Get (File, Entier_2);
                if Entier_1 <0 or Entier_2 <0 then
                    raise Donnee_Error_negative;
                elsif Entier_1  > Facteurs'Length  or  Entier_2 > Facteurs'Length then
                    raise Donnee_Error_taille;
                else
                    null;
                end if;
                Facteurs(Entier_1+1) := Facteurs(Entier_1+1)+1.0;
                Matrices_Creuses_Inst.Modifier(H, Entier_1+1, Entier_2+1);
                --Vecteurs_Creux.Incremente(H(Entier_2+1), Entier_1+1);
            end loop;
        exception
            when End_Error =>
                null;
            when Donnee_Error_taille =>
                Put_Line("Veuillez veiller à fournir un fichier avec des numéros de sommet inférieur à la taille du graphe");
            when Donnee_Error_negative =>
                Put_Line("Veuillez veiller à fournir un fichier avec des numéros de sommet positifs");
        end;
	Close (File);
    Taille_Float := Long_Float(Facteurs'Length);
    for I in 1..Facteurs'Length loop
            if abs(Facteurs(I))<=0.00001 then
                Facteurs(I):=Taille_Float;
                --  for J in 1..Facteurs'Length loop
                --      Vecteurs_Creux.Modifier(H(J), I, 1.0/Taille_Float);
                --      Facteurs(I):=1.0;
                --  end loop;
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
