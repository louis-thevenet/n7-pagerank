with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses_Inst.T_Matrice; Lignes_Non_Nulles : in out T_Vecteur_Creux; Taille:Integer) is
        Entier_1, Entier_2 : Integer;
        Tmp : Matrices_Creuses_Inst.T_Matrice;
        Tmp2 : Long_Float;
        I : Integer;

          Tete, Tete_Lignes_Non_Nulles  : T_Vecteur_Creux;
  Nombre_Cellules : Long_Float;
          begin
        begin
            Tmp := H;
            I:=0;
            while not End_Of_file (File) loop
                Get (File, Entier_1);
                Get (File, Entier_2);
                Vecteurs_Creux.Incremente(Lignes_Non_Nulles, Entier_1+1);
                Vecteurs_Creux.Incremente(H(Entier_2+1), Entier_1+1);
                --Matrices_Creuses_Inst.Modifier(H, Entier_1+1, Entier_2+1, 1.0);

            end loop;
        exception
            when End_Error =>
                null;
        end;
	Close (File);

    -- lignes nulles => 1/Taille
    I := 1;
    Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;
    while Tete_Lignes_Non_Nulles /= Null loop
        if Tete_Lignes_Non_Nulles.Indice /= I then
            for J in 1.. Taille loop
                Vecteurs_Creux.Modifier(H(J), I, 1.0/Long_Float(Taille));

            end loop;
        else
            Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
        end if;
        I := I+1;
    end loop;





      for colonne in 1..Taille loop
          Tete := H(colonne);
          Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;

          -- on pondère les lignes non nulles
          for I in 1..Taille loop
              if Tete = Null then
                  null;
              elsif Tete.Indice = I then
                  if Tete_Lignes_Non_Nulles = Null then

                      Nombre_Cellules := 1.0;
                  elsif Tete_Lignes_Non_Nulles.Indice = I then
                          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
                          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
                  else
                      while Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice < I loop
                          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
                      end loop;
                      if Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice = I then
                          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
                      else
                          Nombre_Cellules := 1.0;
                      end if;
                  end if;


                  Tete.Valeur := Tete.Valeur / Nombre_Cellules;
                  Tete := Tete.Suivant;
              else
                  while Tete /= Null and then Tete.Indice < I loop
                      Tete := Tete.Suivant;
                  end loop;
              end if;
          end loop;
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