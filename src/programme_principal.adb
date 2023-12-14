with PageRank; use PageRank;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Programme_Principal is

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
        Put_Line(" Vous devez renseigner une valeur réelle de Alpha comprise entre 0 et 1 .");
        Put_Line(" La pondération Alpha est appelée le dumping factor. Plus sa valeur est proche de 1, plus la convergence du calcul de la matrice de Google est lente.");
        Put_Line("Par défaut cette valeur de Alpha est fixée à 0.85 .");
        New_Line;
        Put_Line("-K <valeur>");
        Put_Line(" Vous devez renseigner une valeur de k entière positive.");
        Put_Line(" k est l'indice du vecteur poids à calculer.");
        Put_Line("Par défaut cette valeur de k est fixée à 150.");
        New_Line;
        Put_Line("-E <valeur>");
        Put_Line("Vous devez renseigner une valeur de Epsilon entière positive.");
        Put_Line("Epsilon est la précision qui permettra d’interrompre le calcul du Page-Rank si le vecteur poids est à");
        Put_Line("une distance du vecteur poids précédent strictement inférieureà Epsilon.");
        Put_Line("Par défaut cette valeur de Epsilon est nulle.");
        New_Line;
        Put_Line ("-R <Prefixe>");
        Put_Line ("Vous devez renseigner le Prefixe de votre fichier que l'algorithme va vous renvoyer (nom du fichier de sortie).");
        Put_Line ("Par défaut cette valeur de Prefixe est output.");
        New_Line;
        Put_Line ("-P");
        Put_Line ("Il n'y a pas de valeur d'argument à donner.");
        Put_Line ("Permet de choisir l'algorithme avec des matrices Pleines (la matrice G est calculée).");
        Put_Line ("Attention, vous ne pouvez pas activer à al fois le mode Creuse et à la fois le mode Pleine");
        New_Line;
        Put_Line ("-C");
        Put_Line ("Il n'y a pas de valeur d'argument à donner.");
        Put_Line ("Permet de choisir l'algorithme avec des matrices Creuses (la matrice G n'est pas calculée).");
        Put_Line ("Attention, vous ne pouvez pas activer à al fois le mode Creuse et à la fois le mode Pleine");
        Put_Line ("Cet algorithme est celui executé par défaut.");
        New_Line;
        Put_Line("En fin de ligne de commande indiquez le fichier graphe que vous voulez fournir au programme");
        New_line;
        Put_Line("Exemple de commande : ./PageRank -A 0.85 -K 150 -E 0.0001 -C -R output graphe.txt");

    end Help;

    -- Initialiser les variables
        Alpha : Long_Float := 0.85;
        K : Integer := 150;
        Epsilon : Long_Float := 0.0;
        Creuse : Boolean := True;
        Pleine : Boolean := False;
        Prefixe : Unbounded_String := To_Unbounded_String ("output");
        Fichier_graphe : Unbounded_String := To_Unbounded_String ("");
        cas_option : String (1..2);
        cas_option_car: Character;
begin

    -- Vérifier que le nom du fichier est fourni et le récupérer
    if Argument_Count < 1 then
        raise No_Argument_Error;
        else
            Fichier_graphe := To_Unbounded_String(Argument(Argument_Count));
        end if;

    for i in 1..Argument_Count-1 loop
        if  Argument(i)'Length=2 and Argument(i)(1) = '-' then
            cas_option := Argument(i);


            cas_option_car := cas_option(2);
            case cas_option_car is
                when 'A' =>
                    if Float'Value(Argument(i+1)) >=0.0 and Float'Value(Argument(i+1)) <= 1.0 then
                        Alpha:= Long_Float'Value(Argument(i+1));
                    else
                        Put_Line("Vous devez respecter les conditions sur Alpha");
                        New_Line;
                        raise Argument_Error;
                    end if;
                when 'E' =>
                    if Float'Value(Argument(i+1)) >=0.0 then
                        Epsilon := Long_Float'Value(Argument(i+1));
                    else
                        Put_Line("Vous devez respecter les conditions sur Epsilon");
                        New_Line;
                        raise Argument_Error;
                    end if;
                when 'K' =>
                    if Float'Value(Argument(i+1)) >=0.0 then
                        K := Integer'Value(Argument(i+1));
                    else
                        Put_Line("Vous devez respecter les conditions sur k");
                        New_Line;
                        raise Argument_Error;
                    end if;
                when 'C' =>
                    Creuse := True;
                    if Pleine then
                        Put_Line ("Attention, vous ne pouvez pas activer à la fois le mode Creuse et à la fois le mode Pleine");
                        New_Line;
                        raise Argument_Error;
                    end if;
                when 'P' =>
                    Pleine := True;
                when 'R' =>
                    Prefixe := To_Unbounded_String(Argument(i+1));
                when others =>
                    raise Mauvais_Argument_Error;
            end case;
        end if;
    end loop;
    Algorithme_PageRank(Alpha, K, Epsilon, Pleine, To_String(Prefixe), To_String(Fichier_graphe));

exception
    when Argument_Error
        | No_Argument_Error =>
            Help;
        when Mauvais_Argument_Error =>
            Put_Line(" Vous devez renseigner uniqument les arguments pris en charge par le programme ");
            Help;
end Programme_Principal;




