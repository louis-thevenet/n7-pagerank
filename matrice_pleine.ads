generic
    type T_Element is private;
    Capacite : Integer;

package Matrice_Pleine is

private
    type T_Tab is array (1..Capacite) of T_Element;
    type T_Matrice is array (1..Capacite) of T_Tab;
end Matrice_Pleine;