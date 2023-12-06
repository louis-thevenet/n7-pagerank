with Ada.Text_IO;			use Ada.Text_IO;
with Matrices_Creuses;

generic
   with package Matrices is new Matrices_Creuses (<>);
package Lire_Graphe is
procedure Completer_Graphe (File : in out Ada.Text_IO.File_Type; H : in out Matrices.T_Matrice);

end Lire_Graphe;