with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

package commands is
    
    type T_couple is private;
    type T_Tableau is private;
    
    -- On parcourt une chaine de caractère pour identifier les différents arguments
    function Parcourir(commande: in String) return T_Tableau;
    
    -- On traite les arguments appelés par l'utilisateur --
    procedure Traiter_argument(alpha: in out Long_Float ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String );

    procedure Validite(alpha: in out Integer ; k: in out Integer ; epsilon: in out Long_Float ; creuse: in out Boolean ; pleine: in out Boolean ; prefixe: in out Unbounded_String; fichier_graphe: in out Unbounded_String);
    
private 
    type T_couple is record
        Nom_Argument: Character;
        Argument: Unbounded_String;
    end record;
    -- Invariants --
    type T_Tableau is array(1..6) of T_couple; 
    -- Invariants --
    
end commands;
