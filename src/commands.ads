with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

package commands is 
    
    -- Fonction aide en cas d'erreur sur la ligne de commande qui explique le fonctionnement du programme --
    procedure Help;
    
    -- On traite les arguments appelés par l'utilisateur en vérifiant leur validité--
    procedure Traiter_argument(commande: in Unbounded_String; alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String );

end commands;
