with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Vecteurs_Creux;			use Vecteurs_Creux;

package body Lire_Graphe is
    procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses.T_Matrice; Taille:Integer) is
        Entier_1, Entier_2 : Integer;
        Total : Long_Float;

        Changes : T_Vecteur_Creux;
        Tmp : Matrices_Creuses.T_Matrice;
        Tmp2 : Long_Float;
        I : Integer;
        begin
    	begin
        Tmp := H;

    Changes := Null;
    while not End_Of_file (File) loop
        Get (File, Entier_1);
        Get (File, Entier_2);

        Vecteurs_Creux.Modifier(Changes, Entier_1+1, Vecteurs_Creux.Composante_Iteratif(Changes, Entier_1+1)+1.0);

        while Tmp /= Null and then Tmp.Precedent /= Null and then Tmp.Indice > Entier_2+1 loop
            Tmp := Tmp.Precedent;
        end loop;

        while Tmp /= Null and then Tmp.Suivant /= Null and then Tmp.Indice < Entier_2+1 loop
            Tmp := Tmp.Suivant;
        end loop;
        if Tmp /= Null then
            --Tmp2 := Vecteurs_Creux.Composante_Iteratif(Tmp.Valeur, Entier_1+1); -- ici une fonction incrémenter diviserait par 2 le temps d'exécution
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
    Matrices_Creuses.Afficher(H);
    new_line;

    while Changes/=Null loop
        Tmp := H;
        while Tmp /= Null loop
            Matrices_Creuses.Modifier(Tmp, Changes.Indice, Tmp.Indice, Vecteurs_Creux.Composante_Iteratif(Tmp.Valeur, Changes.Indice)/Changes.Valeur);
            Tmp := Tmp.Suivant;

        end loop;

        Changes := Changes.Suivant;
    end loop;
    Matrices_Creuses.Afficher(H);

    --  -- Pondération
    --  Tmp := H;
    --  for I in 1.. Taille loop
    --      Total :=0.0;
    --      for J in 1.. Taille loop
    --          while Tmp /= Null and then Tmp.Precedent /= Null and then Tmp.Indice > J loop
    --              Tmp := Tmp.Precedent;
    --          end loop;

    --          while Tmp /= Null and then Tmp.Suivant /= Null and then Tmp.Indice < J loop
    --              Tmp := Tmp.Suivant;
    --          end loop;
    --          Total := Total + Matrices_Creuses.Element(Tmp,I,J);
    --      end loop;

    --      if Total >= 0.000001 then
    --          for J in 1.. Taille loop
    --              while Tmp /= Null and then Tmp.Precedent /= Null and then Tmp.Indice > J loop
    --                  Tmp := Tmp.Precedent;
    --              end loop;

    --              while Tmp /= Null and then Tmp.Suivant /= Null and then Tmp.Indice < J loop
    --                  Tmp := Tmp.Suivant;
    --              end loop;
    --              Matrices_Creuses.Modifier(Tmp,I,J,Matrices_Creuses.Element(Tmp,I,J)/total);
    --          end loop;
    --      else
    --          null;
    --      end if;
    --  end loop;

    --  Tmp := H;
    --  while Tmp /= Null loop
    --      Total :=0.0;
    --      Tmp2 := Tmp.Valeur;
    --      while Tmp2 /= Null loop
    --          Total := Total + Tmp2.Valeur;
    --          Tmp2 := Tmp2.Suivant;
    --      end loop;

    --      if Total >= 0.000001 then
    --          Tmp2 := Tmp.Valeur;
    --          while Tmp2 /= Null loop
    --              Tmp2.Valeur := Tmp2.Valeur/total;
    --              Tmp2:=Tmp2.Suivant;
    --          end loop;
    --      else
    --          null;
    --      end if;
    --      Tmp := Tmp.Suivant;
    --  end loop;
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