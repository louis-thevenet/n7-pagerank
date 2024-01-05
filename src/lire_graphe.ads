with Ada.Text_IO;			use Ada.Text_IO;
with Matrices_Creuses;
with Matrices_Pleines;
with Vecteurs_Creux; use Vecteurs_Creux;

generic
    N : Integer;
   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
    with package Matrices_Creuses_Inst is new Matrices_Creuses (<>);

package Lire_Graphe is
procedure Completer_Graphe_Pleine (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Pleines_Inst.T_Matrice);
procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses_Inst.T_Matrice; Facteurs : in out Matrices_Creuses_Inst.T_Facteurs; Taille:Integer);

end Lire_Graphe;