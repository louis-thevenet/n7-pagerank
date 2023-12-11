with PageRank; use PageRank;
with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Programme_Principal is

begin
    package body commands is

    procedure Traiter_argument(commande: in Unbounded_String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String ) is
    i : Integer;
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

        -- on est obligé d'utiliser un while car on pourrait pas modiifer l'indice de parcours i à notre guise avec un if --
        while i <= Argument_Count loop
            -- on ne peut pas faire de case car Argument(i) est une String  donc un type non discret --
 --
            if Argument (i) = "-A" then
                alpha := Long_Float'Value(Argument(i+1));
                i := i+2;
            elsif Argument (i) = "-K" then
                k := Integer'Value(Argument(i+1));
                i := i+2;
            elsif Argument (i) = "-P" then
                pleine := True;
                i := i+1;
            elsif Argument (i) = "-C" then
                i := i+1;
            elsif Argument (i)= "-E" then
                epsilon := Long_Float'Value(Argument(i+1));
                i := i+2;
            elsif Argument (i)= "-R" then
                prefixe := To_Unbounded_String(Argument(i+1));
                i := i+2;
            elsif Argument (i) = "" then
                fichier_graphe := To_Unbounded_String(Argument(i+1));
                i := i+2;
            end if;

        end loop;
    end Traiter_argument;

    procedure Validite(argument: in String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean) is
    begin
        -- on ne peut pas faire de case car Argument(i) est une String  donc un type non discret --
            if argument="alpha" then
                if Long_Float'Value(alpha)<Long_Float'Value(0) or Long_Float'Value(alpha)>Long_Float'Value(1)  then
                    Put("Alpha doit être compris entre 0 et 1 au sens large");
                    raise Error_Argument;
                end if;
            elsif argument="epsilon" then
                 if epsilon<0 then
                    Put("epsilon  doit être positif");
                    raise Error_Argument;
                end if;
            elsif argument="matrice" then
                if pleine=creuse then
                    Put("Vous ne pouvez pas choisir à la fois le mode matrice pleine et le mode matrice creuse");
                    raise Error_Argument;
                end if;
            elsif argument="k" then
                if k<0 then
                    Put("k  doit être positif");
                    raise Error_Argument;
                end if;
           else
                Put("Il faut spécifier un fichier d'entrée");
                raise Error_Argument;
            end if;

    end Validite;
end commands;
    Algorithme_PageRank(0.85, 150, 0.0, true, "testoutput", "exemple-fichier.txt");

end Programme_Principal;




