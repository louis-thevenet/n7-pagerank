with Ada.Text_IO;			use Ada.Text_IO;
package Lire_Graphe is



generic
   type T_Matrice is private;
   with function Element (M : T_Matrice; I :in Integer; J : in Integer) return Long_Float;
   with procedure Modifier_Element (M : in out T_Matrice; I :in Integer; J : in Integer; Nouveau : in Long_Float);
   with function Taille(M : in T_Matrice) return Integer;

procedure Completer_Graphe (File : in out Ada.Text_IO.File_Type; G : in out T_Matrice);


end Lire_Graphe;