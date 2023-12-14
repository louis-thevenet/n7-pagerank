with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body commands is

    -- Initilisation des exceptions
    Argument_Error : exception;
    No_Argument_Error : exception;
    Mauvais_Argument_Error : exception;

    procedure Help is
    begin
        Put_Line("Fonctionnement du programme PageRank.");
        New_Line;
        Put_Line("Il y a une erreur dans la saisie de vos arguments.");
        New_Line;
        Put_Line("Arguments :");
        New_Line;
        Put_Line("-A <valeur>");
        Put_Line(" Vous devez renseigner une valeur réelle de alpha comprise entre 0 et 1 .");
        Put_Line(" La pondération alpha est appelée le dumping factor. Plus sa valeur est proche de 1, plus la convergence du calcul de la matrice de Google est lente.");
        Put_Line("Par défaut cette valeur de alpha est fixée à 0.85 .");
        New_Line;
        Put_Line("-K <valeur>");
        Put_Line(" Vous devez renseigner une valeur de k entière positive.");
        Put_Line(" k est l'indice du vecteur poids à calculer.");
        Put_Line("Par défaut cette valeur de k est fixée à 150.");
        New_Line;
        Put_Line("-E <valeur>");
        Put_Line(" Vous devez renseigner une valeur de epsilon entière positive.");
        Put_Line(" epsilon est la précision qui permettra d’interrompre le calcul du Page-Rank si le vecteur poids est à ");
        Put_Line("une distance du vecteur poids précédent strictement inférieureà epsilon.");
        Put_Line("Par défaut cette valeur de epsilon est nulle.");
        New_Line;
        Put_Line ("-R <prefixe>");
        Put_Line ("Vous devez renseigner le prefixe de votre fichier que l'algorithme va vous renvoyer (nom du fichier de sortie).");
        Put_Line ("Par défaut cette valeur de prefixe est output.");
        New_Line;
        Put_Line ("-P");
        Put_Line ("Il n'y a pas de valeur d'argument à donner.");
        Put_Line ("Permet de choisir l'algorithme avec des matrices pleines (la matrice G est calculée).");
        Put_Line ("Attention, vous ne pouvez pas activer à al fois le mode creuse et à la fois le mode pleine");
        New_Line;
        Put_Line ("-C");
        Put_Line ("Il n'y a pas de valeur d'argument à donner.");
        Put_Line ("Permet de choisir l'algorithme avec des matrices creuses (la matrice G n'est pas calculée).");
        Put_Line ("Attention, vous ne pouvez pas activer à al fois le mode creuse et à la fois le mode pleine");
        Put_Line ("Cet algorithme est celui executé par défaut.");
        New_Line;
        Put_Line("En fin de ligne de commande indiquez le fichier graphe que vous voulez fournir au programme");
        New_Line;
        Put_Line("Exemple de commande : ./PageRank -A 0.85 -K 150 -E 0.0001 -C -R output graphe.txt");
    end Help;



    procedure Traiter_argument(commande: in Unbounded_String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String ) is
        i : Integer; -- indice de notre boucle while
        cas_option : String (1..2);
        cas_option_car: Character;
    begin
        -- Initialisation des variables avec les valeurs par défaut imposées par l'énoncé --
        alpha := 0.85;
        k := 150;
        epsilon := 0.0;
        creuse := True;
        pleine := False;
        prefixe := To_Unbounded_String ("output");
        fichier_graphe := To_Unbounded_String ("");
        i:=1;

        begin
        -- Vérifier que le nom du fichier est fourni et le récupérer
	    if Argument_Count < 1 then
		    raise No_Argument_Error;
         else
                fichier_graphe := To_Unbounded_String(Argument(Argument_Count));
         end if;

        for i in 1..Argument_Count-1 loop
            cas_option := Argument(i);
            if  cas_option'Length=2 and cas_option(1) = '-' then
                cas_option_car := cas_option(2);
                case cas_option_car is
                    when 'A' =>
                        if Float'Value(Argument(i+1)) >=0.0 and Float'Value(Argument(i+1)) <= 1.0 then
                            alpha:= Long_Float'Value(Argument(i+1));
                        else
                            Put_Line("Vous devez respecter les conditions sur alpha");
                            raise Argument_Error;
                        end if;
                    when 'E' =>
                        if Float'Value(Argument(i+1)) >=0.0 then
                            epsilon := Long_Float'Value(Argument(i+1));
                        else
                             Put_Line("Vous devez respecter les conditions sur epsilon");
                            raise Argument_Error;
                        end if;
                    when 'K' =>
                        if Float'Value(Argument(i+1)) >=0.0 then
                            k := Integer'Value(Argument(i+1));
                        else
                            Put_Line("Vous devez respecter les conditions sur k");
                            raise Argument_Error;
                        end if;
                    when 'C' =>
                        creuse := True;
                        if pleine = True then
                            Put_Line ("Attention, vous ne pouvez pas activer à al fois le mode creuse et à la fois le mode pleine");
                            raise Argument_Error;
                        end if;
                    when 'P' =>
                        pleine := True;
                    when 'R' =>
                        prefixe := To_Unbounded_String((i+1));
                    when others =>
                        raise Mauvais_Argument_Error;
                end case;
            end if;
        end loop;

        exception
            when Argument_Error =>
                Help;
            when Mauvais_Argument_Error =>
                Put_Line(" Vous devez renseigner uniqument les arguments pris en charge par le programme ");
                Help;
        end;


     end Traiter_argument;

end commands;
