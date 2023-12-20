with Ada.Text_IO;			use Ada.Text_IO;
with Matrices_Creuses; use Matrices_Creuses;
with Matrices_Pleines;

generic
   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
package Lire_Graphe is
procedure Completer_Graphe_Pleine (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Pleines_Inst.T_Matrice);
procedure Completer_Graphe_Creuse (File : in out Ada.Text_IO.File_Type; H : in out Matrices_Creuses.T_Matrice; Taille:Integer);

end Lire_Graphe;