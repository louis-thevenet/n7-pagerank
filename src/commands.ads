with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

package commands is 
    
    Error_Argument: Exception;
    
    -- On traite les arguments appelés par l'utilisateur --
    procedure Traiter_argument(commande: in Unbounded_String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String );

    procedure Validite(argument: in String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean);
    
end commands;
