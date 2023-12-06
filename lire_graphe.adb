package body Lire_Graphe is
    procedure Completer_Graphe (File : in Ada.Text_IO.File_Type; G : in out T_Matrice) is
        Entier_1, Entier_2 : Integer;
    	begin
		Put_Line ("--   Lire les autres entiers");
		while not End_Of_file (File) loop
			Get (File, Entier_1);
            Get (File, Entier_2);

            G.Adj(Entier_1, Entier_2) := G.Adj(Entier_1, Entier_2)+1;
		end loop;
		Put_Line ("[fini]");
	exception
		when End_Error =>
			-- la fin du fichier a été atteinte.
			-- se produit en particulier si on a des caractères après le
			-- dernier entier (un blanc, une ligne vide)
			null;
			Put_Line ("[fin du fichier détectée sur exception]");
	end;

	Close (File);

    end Completer_Graphe;


    function Creer_Graphe (Nom_Fichier : in String; Pleine : in Boolean) return T_Graphe is
    	File : Ada.Text_IO.File_Type; -- descripteur de fichier texte (Ada.Text_IO)
        Flottant : Float;
        Nom_Fichier : Unbounded_String;

        Taille : Integer;
        begin
	        Get (File, Taille);

        if Pleine then
            declare
            package Matrice_Pleine_Inst is new Matrice_Pleine(Taille, Integer);
            use Matrice_Pleine_Inst;

            procedure Completer_Graphe_Ins is new Completer_Graphe(T_Matrice);
            Graphe : T_Matrice;
            begin
                Initialiser_Matrice(Graphe);
                Completer_Graphe(File, Graphe);
            end;
        else
            null;
        end if;
        return G;
    end Creer_Graphe;
end Lire_graphe;