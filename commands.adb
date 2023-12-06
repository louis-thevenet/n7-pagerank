with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Strings.Unbounded;  use Ada.Strings.Unbounded;

package body commands is

    function Parcourir(commande: in String) return T_Tableau is
        tableau: T_Tableau;
        k: Integer;
    begin
        k := 1;
        for i in 1..commande'Last loop
            if commande(i) = '-' then
                tableau(k).Nom_Argument := commande(i+1);
                if commande(i+1)='P'|commande(i+1)='C' then
                    tableau(k).Argument := 0;
                else
                    while commande(i) /= '-' loop
                        tableau(k).Argument := float;
                 end if;
            k := k+1;
            end if;
        end loop;
        return tableau;
    end Parcourir;



    procedure Traiter_argument(commande: in String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String ) is
    Aide: Unbounded_String;
    begin
        -- Initialisation des variables avec les valeurs par défaut imposées par l'énoncé --
        alpha := 0.85;
        k := 150;
        epsilon := 0.0;
        creuse := True;
        pleine := False;
        prefixe := To_Unbounded_String ("output");
        fichier_graphe := To_Unbounded_String ("");
        Aide := To_Unbounded_String ("");


        Case Nom_Argument is
           when "A" => alpha := Argument;
           when "K" => k := argument;
           when "E" => epsilon  := Argument;
           when "P" => creuse := true;
           when "C" => pleine := false;
           when "R" => prefixe := Argument;
           when others => if fichier_graphe = "" then
                        fichier_graphe := Argument;
                     else
                        Put("Cet argument n’existe pas");
                        Put(Aide);
                    end if;
            end Case;
    end Traiter_argument;

    procedure Validite(alpha: in out Integer ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String ) is
        Null;

end commands;
